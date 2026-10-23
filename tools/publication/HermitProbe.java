import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import org.semanticweb.owlapi.apibinding.OWLManager;
import org.semanticweb.owlapi.model.*;
import org.semanticweb.owlapi.reasoner.OWLReasoner;
import org.semanticweb.HermiT.ReasonerFactory;

/** A small read-only OWLAPI/HermiT probe using the hash-pinned ROBOT JAR. */
public class HermitProbe {
  public static void main(String[] args) throws Exception {
    OWLOntologyManager manager = OWLManager.createOWLOntologyManager();
    for (String line : Files.readAllLines(Path.of(args[0]))) {
      if (line.isBlank()) continue;
      String[] cols = line.split("\t", -1);
      OWLOntology ontology = manager.loadOntologyFromOntologyDocument(new File(cols[1]));
      if (!ontology.getImportsDeclarations().isEmpty()) throw new IllegalStateException("Unexpected import");
      OWLReasoner reasoner = new ReasonerFactory().createReasoner(ontology);
      System.out.println(cols[0] + "\tVERSION\t" + reasoner.getReasonerVersion());
      boolean consistent = reasoner.isConsistent();
      System.out.println(cols[0] + "\tCONSISTENT\t" + consistent);
      if (consistent && cols[0].equals("tbox")) {
        List<OWLClass> classes = new ArrayList<>(ontology.getClassesInSignature());
        classes.sort(Comparator.comparing(c -> c.getIRI().toString()));
        for (OWLClass cls : classes) {
          if (cls.isOWLThing() || cls.isOWLNothing()) continue;
          System.out.println("tbox\tSAT\t" + cls.getIRI() + "\t" + reasoner.isSatisfiable(cls));
        }
      }
      if (consistent && !cols[2].isBlank()) {
        OWLOntologyManager queryManager = OWLManager.createOWLOntologyManager();
        OWLOntology query = queryManager.loadOntologyFromOntologyDocument(new File(cols[2]));
        List<OWLLogicalAxiom> axioms = new ArrayList<>(query.getLogicalAxioms());
        axioms.sort(Comparator.comparing(Object::toString));
        if (axioms.isEmpty()) throw new IllegalStateException("Empty entailment query");
        for (OWLLogicalAxiom axiom : axioms) {
          System.out.println(cols[0] + "\tENTAIL\t" + reasoner.isEntailed(axiom) + "\t" + axiom);
        }
      }
      reasoner.dispose();
      manager.removeOntology(ontology);
    }
  }
}
