using System;
using System.Collections.Generic; 
using System.Linq;
using System.Text;
using System.Xml;
using System.Xml.Linq;
using System.Xml.Xsl;
using System.IO;
using System.Web;

namespace ICPMD.Modules
{
    class AndroidAppProducer
    {

        public static void resources_converter(string path, string project_name)
        {
            string project_path = path;
            string source_path = path + "\\Abstract\\" + project_name;

            //----------- copy assets folder --------------------------------------------
            //----------- copy application icon -----------------------------------------
            try
            {
                // create folder if not exist
                bool isExists = System.IO.Directory.Exists(project_path + "\\Android\\" + project_name + "\\res\\drawable-hdpi");
                if (!isExists)
                    System.IO.Directory.CreateDirectory(project_path + "\\Android\\" + project_name + "\\res\\drawable-hdpi");
                foreach (string f in Directory.GetFiles(project_path + "\\Abstract\\" + project_name + "\\Assets"))
                {
                    File.Copy(f, project_path + "\\Android\\" + project_name + "\\res\\drawable-hdpi\\" + f.Substring(f.LastIndexOf("\\")).ToLower());
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
            //----------- copy sound files -----------------------------------------
            try
            {
                // create folder if not exist
                bool isExists = System.IO.Directory.Exists(project_path + "\\Android\\" + project_name + "\\res\\raw");
                if (!isExists)
                    System.IO.Directory.CreateDirectory(project_path + "\\Android\\" + project_name + "\\res\\raw");
                foreach (string f in Directory.GetFiles(project_path + "\\Abstract\\" + project_name + "\\Assets\\Sound"))
                {
                    File.Copy(f, project_path + "\\Android\\" + project_name + "\\res\\raw\\" + f.Substring(f.LastIndexOf("\\")).ToLower());
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
            //----------- copy functions file -------------------------------------------
            try
            {
            bool isExists1 = System.IO.Directory.Exists(project_path + "\\Android\\" + project_name + "\\src\\edu\\icpmd");
            if (!isExists1)
                System.IO.Directory.CreateDirectory(project_path + "\\Android\\" + project_name + "\\src\\edu\\icpmd");

            foreach (string f in Directory.GetFiles(HttpContext.Current.Server.MapPath("~/ProjectFiles/Android/components")))
            {
                File.Copy(f, project_path + "\\Android\\" + project_name + "\\src\\edu\\icpmd\\" + f.Substring(f.LastIndexOf("\\")).ToLower());
            }
            //File.Copy(@"ProjectFiles\Android\functions.java", project_path + "\\Android\\" + project_name + "\\src\\edu\\icpmd\\functions.java");              
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
            //----------- copy project files --------------------------------------------
            try
            {
                // create folder if not exist
                bool isExists2 = System.IO.Directory.Exists(project_path + "\\Android\\" + project_name);
                if (!isExists2)
                    System.IO.Directory.CreateDirectory(project_path + "\\Android\\" + project_name);

                File.Copy(HttpContext.Current.Server.MapPath("~/ProjectFiles/Android/.classpath"), project_path + "\\Android\\" + project_name + "\\.classpath");
                File.Copy(HttpContext.Current.Server.MapPath("~/ProjectFiles/Android/.project"), project_path + "\\Android\\" + project_name + "\\.project");
                File.Copy(HttpContext.Current.Server.MapPath("~/ProjectFiles/Android/project.properties"), project_path + "\\Android\\" + project_name + "\\project.properties");
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }

            //-------------------------add the name project name element to the xml file ---------------------------
            XmlDocument doc = new XmlDocument();
            using (XmlTextReader tr = new XmlTextReader(project_path + "\\Android\\" + project_name + "\\.project"))
            {
                tr.Namespaces = false;
                doc.Load(tr);
            }
            XmlElement elmRoot = doc.DocumentElement;
            XmlNamespaceManager namespaceManager = new XmlNamespaceManager(doc.NameTable);
            //XmlNode spanNode;
            //-------- seach for pageinitializer ---------------------------------
            //string id = "InitializeComponent";
            string xPath = "//projectDescription//name";
            XmlNode findnode = doc.SelectSingleNode(xPath, namespaceManager);
            try
            {
                //foreach (XmlNode node in findnode)
                //{
                //XmlNode 
                //spanNode = doc.CreateElement("namespace", project_name);
                //MessageBox.Show(node.ParentNode.ParentNode.ParentNode.OuterXml);
                findnode.InnerText = project_name; //.ReplaceChild(spanNode);
                //}
            }
            catch
            {
                //MessageBox.Show(xPath);
            }


            doc.Save(project_path + "\\Android\\" + project_name + "\\.project");

        }

        public static void manifest_converter(string path , string project_name)
        {
            string project_path = path;
            string xmlPath = project_path + "\\Abstract\\" + project_name + "\\Manifest\\manifest.xml";
            string xslPath = HttpContext.Current.Server.MapPath("~/XSLT/") + "\\AM_to_Android_Manifest.xslt";
            string resultPath = project_path + "\\Android\\" + project_name + "\\AndroidManifest.xml";

            //XmlReader loads XML file
            XmlReader reader = XmlReader.Create(xmlPath);

            // create folder if not exist
            bool isExists = System.IO.Directory.Exists(project_path + "\\Android\\" + project_name);
            if (!isExists)
                System.IO.Directory.CreateDirectory(project_path + "\\Android\\" + project_name);

            //XmlTextWriter creats output file
            XmlTextWriter writer = new XmlTextWriter(resultPath, null);

            //XslCompiledTransform loads XSLT file
            XslCompiledTransform xsl = new XslCompiledTransform();
            xsl.Load(xslPath);
            xsl.Transform(reader, writer);
            writer.Close();
            //textBox2.Text = File.ReadAllText(project_path + "\\Abstract\\Manifest\\manifest.xml");

        }

        public static void ui_converter(string path, string project_name)
        {
            string project_path = path;
            foreach (string f in Directory.GetFiles(project_path + "\\Abstract\\" + project_name + "\\UI"))
                if (f.EndsWith(".xml"))
                {
                    String file_name = f.Substring(f.LastIndexOf("\\"));
                    string xmlPath = project_path + "\\Abstract\\" + project_name + "\\UI\\" + file_name;
                    string xslPath = HttpContext.Current.Server.MapPath("~/XSLT/") + "\\AM_to_Android_UI.xslt";
                    file_name = file_name.Substring(1, file_name.IndexOf(".") - 1);
                    string resultPath = project_path + "\\Android\\" + project_name + "\\res\\layout\\" + file_name.ToLower() + ".xml";

                    //XmlReader loads XML file
                    XmlReader reader = XmlReader.Create(xmlPath);

                    // create folder if not exist
                    bool isExists = System.IO.Directory.Exists(project_path + "\\Android\\" + project_name + "\\res\\layout");
                    if (!isExists)
                        System.IO.Directory.CreateDirectory(project_path + "\\Android\\" + project_name + "\\res\\layout");

                    //XmlTextWriter creats output file
                    XmlTextWriter writer = new XmlTextWriter(resultPath, null);

                    //XslCompiledTransform loads XSLT file
                    XslCompiledTransform xsl = new XslCompiledTransform();
                    xsl.Load(xslPath);
                   xsl.Transform(reader, writer);
                    //end new code
                    writer.Close();
                    //-------------- generating the menu file ------------------------------------------
                    xmlPath = project_path + "\\Abstract\\" + project_name + "\\Menu\\" + file_name +".xml";
                    xslPath = HttpContext.Current.Server.MapPath("~/XSLT/") + "\\AM_to_Android_Menu.xslt";
                    //file_name = file_name.Substring(1, file_name.IndexOf(".") - 1);
                    resultPath = project_path + "\\Android\\" + project_name + "\\res\\menu\\" + file_name.ToLower() + ".xml";

                    //XmlReader loads XML file
                    reader = XmlReader.Create(xmlPath);

                    // create folder if not exist
                    isExists = System.IO.Directory.Exists(project_path + "\\Android\\" + project_name + "\\res\\menu");
                    if (!isExists)
                        System.IO.Directory.CreateDirectory(project_path + "\\Android\\" + project_name + "\\res\\menu");

                    //XmlTextWriter creats output file
                    writer = new XmlTextWriter(resultPath, null);

                    //XslCompiledTransform loads XSLT file
                    xsl = new XslCompiledTransform();
                    xsl.Load(xslPath);
                    var xdoc = XDocument.Load(xmlPath);
                    var configuration = xdoc.Element("menu");

                    if (configuration != null)
                    {
                        xsl.Transform(reader, writer);
                    }
                    //end new code
                    writer.Close();
                    //-------------- end generate the menu file ----------------------------------------
                }
        }

        public static void code_parser(string ast_file_name,string path, string project_name)
        {
            string project_path = path;
                        //------------ initialize page ---------------------------------
            XElement root = XElement.Load(project_path + "\\Android\\Code_Temp\\"+ast_file_name);
            //XElement root = XElement.Load( ast_file_name);
            IEnumerable<XElement> items = from el in root.Descendants("TypeMember_ConstructorDeclaration")
                                          from i in el.Descendants("Statement_ExpressionStatement")
                                          from n in i.Elements("Expression_InvocationExpression")
                                          from m in n.Elements("Target_IdentifierExpression")
                                          where m.Attribute("Identifier").Value == "InitializeComponent"
                                          select i;
            try
            {
                foreach (XElement prdName in items)
                {
                  //  MessageBox.Show(prdName.ToString());
                    prdName.ReplaceNodes(new XElement("ICPMD_Page", new XAttribute("call", "initialize")));
                }
            }
            catch (Exception ex)
            {
               // MessageBox.Show("Processor Usage" + ex.Message);
            }
            //-------------- load webview url --------------------------
            items = from el in root.Descendants("Statement_ExpressionStatement")
                    from i in el.Elements("Expression_InvocationExpression")
                    from n in i.Elements("Target_MemberReferenceExpression")
                    where n.Attribute("MemberName").Value == "Navigate"
                    select el;
            try
            {
                foreach (XElement prdName in items)
                {
                   // MessageBox.Show(prdName.ToString());

                    IEnumerable<XElement> item = from el1 in prdName.Descendants("Argument_ObjectCreateExpression")
                                                 from i1 in el1.Elements("Argument_IdentifierExpression")
                                                 select i1;

                    prdName.ReplaceNodes(new XElement("ICPMD_Webview", new XAttribute("call", "load"), new XElement("url", item.Single().Attribute("Identifier").Value)));
                }
            }
            catch (Exception ex)
            {
               // MessageBox.Show("Processor Usage" + ex.Message);
            }

            //----------------------------------------------------------
            // create folder if not exist
            bool isExists = System.IO.Directory.Exists(project_path + "\\Abstract\\" + project_name + "\\Code");
            if (!isExists)
                System.IO.Directory.CreateDirectory(project_path + "\\Abstract\\" + project_name + "\\Code");
            root.Save(project_path + "\\Abstract\\" + project_name + "\\Code\\" + ast_file_name);
            //root.Save( ast_file_name);
        }
   


     public static void code_generator(string path, string project_name)
        {
            string project_path = path;
            if (!Directory.Exists(project_path + "\\Abstract\\" + project_name + "\\Code"))
            {
                Directory.CreateDirectory(project_path + "\\Abstract\\" + project_name + "\\Code");
            }
            foreach (string f in Directory.GetFiles(project_path + "\\Abstract\\" + project_name + "\\Code"))
                if (f.EndsWith(".xml"))
                {
                    String file_name = f.Substring(f.LastIndexOf("\\"));
                    string xmlPath = project_path + "\\Abstract\\" + project_name + "\\Code\\" + file_name;
                    string xslPath = HttpContext.Current.Server.MapPath("~/XSLT/") + "\\java_code_generator.xslt";
                    if (file_name.StartsWith("\\"))
                    {
                        file_name = file_name.Substring(1, file_name.IndexOf(".") - 1);
                    }
                    else
                    {
                        file_name = file_name.Substring(0, file_name.IndexOf("."));
                    }
                        string resultPath = project_path + "\\Android\\" + project_name + "\\src\\edu\\icpmd\\" + project_name + "\\" + file_name + ".java";

                    //XmlReader loads XML file
                    XmlReader reader = XmlReader.Create(xmlPath);

                    // create folder if not exist
                    bool isExists = System.IO.Directory.Exists(project_path + "\\Android\\" + project_name + "\\src\\edu\\icpmd\\" + project_name + "\\");
                    if (!isExists)
                        System.IO.Directory.CreateDirectory(project_path + "\\Android\\" + project_name + "\\src\\edu\\icpmd\\" + project_name + "\\");

                    //XmlTextWriter creats output file
                    XmlTextWriter writer = new XmlTextWriter(resultPath, null);

                    //XslCompiledTransform loads XSLT file
                    string fname;
                    fname = project_path + "\\Android\\" + project_name + "\\res\\layout\\" + file_name.ToLower() + ".xml";
                    XsltArgumentList argsList = new XsltArgumentList();
                    argsList.AddParam("fname", "", fname);
                    
                    XsltSettings s = new XsltSettings();
                    s.EnableDocumentFunction = true;

                    XslCompiledTransform xsl = new XslCompiledTransform();
                    xsl.Load(xslPath,s, null);
                    xsl.Transform(reader,argsList, writer);
                    writer.Close();
                    //textBox2.Text = File.ReadAllText(project_path + "\\Abstract\\Manifest\\manifest.xml");

                }

        }

        public static void code_analyzer(string ast_file_name)
        {

        }

    }
}
    

