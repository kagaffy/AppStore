#!/usr/bin/env python3
"""
XcodeGen emits XCSwiftPackageProductDependency for local packages without the
required `package = <XCLocalSwiftPackageReference>;` backlink. xcodebuild often
tolerates this, but Xcode.app reports "Missing package product ...".

Run after `xcodegen generate` (wired via project.yml postGenCommand).
See: https://github.com/yonaskolb/XcodeGen/issues/1549
"""

from __future__ import annotations

import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
PBXPROJ = ROOT / "AppStore.xcodeproj" / "project.pbxproj"


def main() -> int:
    if not PBXPROJ.exists():
        print(f"error: {PBXPROJ} not found", file=sys.stderr)
        return 1

    text = PBXPROJ.read_text()

    local_refs: dict[str, tuple[str, str]] = {}
    for match in re.finditer(
        r'([A-F0-9]{24}) /\* (XCLocalSwiftPackageReference "Packages/([^"]+)") \*/ = \{',
        text,
    ):
        local_refs[match.group(3)] = (match.group(1), match.group(2))

    if not local_refs:
        print("fix-local-package-backlinks: no local packages found")
        return 0

    def fix_block(match: re.Match[str]) -> str:
        block = match.group(0)
        if "package =" in block:
            return block
        product_match = re.search(r"productName = ([^;]+);", block)
        if not product_match:
            return block
        product = product_match.group(1).strip()
        if product not in local_refs:
            return block
        uuid, comment = local_refs[product]
        return block.replace(
            "isa = XCSwiftPackageProductDependency;\n",
            "isa = XCSwiftPackageProductDependency;\n"
            f"\t\t\tpackage = {uuid} /* {comment} */;\n",
        )

    new_text, _ = re.subn(
        r"[A-F0-9]{24} /\* [^*]+ \*/ = \{\n"
        r"\t\t\tisa = XCSwiftPackageProductDependency;\n"
        r"(?:\t\t\tpackage = [^\n]+\n)?"
        r"\t\t\tproductName = [^;]+;\n"
        r"\t\t\};",
        fix_block,
        text,
    )

    if new_text == text:
        print("fix-local-package-backlinks: already up to date")
        return 0

    PBXPROJ.write_text(new_text)
    print(
        "fix-local-package-backlinks: "
        f"patched {len(local_refs)} local package product dependencies"
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
