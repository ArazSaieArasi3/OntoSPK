import java.io.File;
import org.semanticweb.owlapi.apibinding.OWLManager;
import org.semanticweb.owlapi.model.*;
/** Compare parsed logical axioms, not RDF spellings or label counts. */
public class MetadataLogicalIdentity {
  public static void main(String[] args) throws Exception {
    OWLOntology a=OWLManager.createOWLOntologyManager().loadOntologyFromOntologyDocument(new File(args[0]));
    OWLOntology b=OWLManager.createOWLOntologyManager().loadOntologyFromOntologyDocument(new File(args[1]));
    if (!a.getImportsDeclarations().isEmpty() || !b.getImportsDeclarations().isEmpty()) throw new IllegalStateException("Unexpected imports");
    if (!a.getLogicalAxioms().equals(b.getLogicalAxioms())) throw new IllegalStateException("Logical axioms changed");
    if (!a.getClassesInSignature().equals(b.getClassesInSignature()) || !a.getObjectPropertiesInSignature().equals(b.getObjectPropertiesInSignature()) || !a.getDataPropertiesInSignature().equals(b.getDataPropertiesInSignature())) throw new IllegalStateException("Logical signature changed");
    System.out.println("IDENTICAL_LOGICAL_AXIOMS\t"+a.getLogicalAxiomCount());
    System.out.println("IDENTICAL_CLASSES\t"+a.getClassesInSignature().stream().filter(c -> !c.isOWLThing() && !c.isOWLNothing()).count());
    System.out.println("IDENTICAL_OBJECT_PROPERTIES\t"+a.getObjectPropertiesInSignature().size());
    System.out.println("IDENTICAL_DATA_PROPERTIES\t"+a.getDataPropertiesInSignature().size());
  }
}
