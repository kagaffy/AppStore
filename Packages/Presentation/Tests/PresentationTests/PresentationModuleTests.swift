import Presentation
import Testing

@Test
func presentationModuleExposesDomainTypes() {
    #expect(!PresentationModule.domainTypesAvailable().isEmpty)
    #expect(PresentationModule.name == "Presentation")
}
