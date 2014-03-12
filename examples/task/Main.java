package cz.muni.fi.pb138.jaro2014.task1;

import java.io.File;
import java.io.IOException;
import java.net.URI;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

/**
 * ***********************************************************************
 * Take this skeleton code and implement the missing bodies of
 * <code>averageSalaryAtDivision</code> and
 * <code>addNote</code> methods. Everything else should be left
 * untouched.<br/>
 *
 * After completion, the <code>main</code> method should work correctly.<br/>
 * It reads (parses) the given file (company.xml if you run it directly 
 * from the Netbeans project) and processes it using your methods.
 *
 */
public class Main {

    /**
     * W3C object model representation of a XML document. Note: We use the
     * interface(!) not its implementation
     */
    private Document doc;

    /**
     * Task 1, part A: Complete this method. 
     * You are likely to consult the Java Core API documentation 
     * for org.w3c.dom package when working on this task.
     * 
     * Hint for those not experienced in Java: you can use 
     * double Double.parseDouble (String s) to convert the 
     * text node inside the salary element to a double value.
     * 
     * You can suppose that the input document is always valid,
     * i.e. its structure fulfills the criteria specified
     * in the comments inside the document company.xml.
     *
     * @param divId did of the division to calculate the average salary at. 
     * divId must neither be null nor empty (the method does not check it)
     * @returns the average salary of all employees and the head of the division
     * or -1 if there is no person to calculate the salary from
     */
    public double averageSalaryAtDivision(String divId) {

        return -1;
    }

    /**
     * Task 1, part B: Complete this method. The method adds a new note
     * to an existing person identified by an person ID (pid).
     * If such a person does not exist, the method does nothing.
     *
     * @param pid pid of the person to add the note to this person. 
     * pid must not be null nor empty (the method does not check it)
     * @param note the note to be added to the person with the given pid
     */
    public void addNote(String pid, String note) {


    }

    /**
     * **********************************************************************
     */
    /**
     * Vytvori novou instanci teto tridy a nacte obsah xml dokumentu se zadanym
     * URL.
     */
    public static Main newInstance(URI uri) throws SAXException,
            ParserConfigurationException, IOException {
        return new Main(uri);
    }

    /**
     * Create a new instance of this class and read the content of the given XML
     * file.
     */
    public static Main newInstance(File file)
            throws SAXException, ParserConfigurationException, IOException {
        return newInstance(file.toURI());
    }

    /**
     * Constructor creating a new instance of Uloha1 class reading from the file
     * at the given URI
     */
    private Main(URI uri) throws SAXException, ParserConfigurationException,
            IOException {
        // Vytvorime instanci tovarni tridy
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        // Pomoci tovarni tridy ziskame instanci DocumentBuilderu
        DocumentBuilder builder = factory.newDocumentBuilder();
        // DocumentBuilder pouzijeme pro zpracovani XML dokumentu
        // a ziskame model dokumentu ve formatu W3C DOM
        doc = builder.parse(uri.toString());
    }

    public void serializetoXML(URI output)
            throws IOException, TransformerConfigurationException, TransformerException {
        // Vytvorime instanci tovarni tridy
        TransformerFactory factory = TransformerFactory.newInstance();
        // Pomoci tovarni tridy ziskame instanci tzv. kopirovaciho transformeru
        Transformer transformer = factory.newTransformer();
        // Vstupem transformace bude dokument v pameti
        DOMSource source = new DOMSource(doc);
        // Vystupem transformace bude vystupni soubor
        StreamResult result = new StreamResult(output.toString());
        // Provedeme transformaci
        transformer.transform(source, result);
    }

    public void serializetoXML(File output) throws IOException,
            TransformerException {
        serializetoXML(output.toURI());
    }

    public static void main(String[] args) throws IOException, SAXException, ParserConfigurationException, TransformerException {

        if (args.length < 1) {
            System.err.println("Input file name is missing.");
            return;
        } else if (args.length < 2) {
            System.err.println("Output file name is missing.");
            return;
        }

        File input = new File(args[0]);
        File output = new File(args[1]);

        Main task1 = newInstance(input);
        
        // expected outputs are:
        // Average salary is 42491.75
        // Average salary is 107948.5

        System.out.println("Average salary in Zlin is "
                + task1.averageSalaryAtDivision("production_zlin"));
        System.out.println("Average salary in Brno is "
                + task1.averageSalaryAtDivision("development_brno"));

        task1.addNote("1", "new note to person 1");
        
        task1.serializetoXML(output);
    }

    /**
     * Help method for testing purposes.
     */
    Document getDocument() {
        return doc;
    }
}
