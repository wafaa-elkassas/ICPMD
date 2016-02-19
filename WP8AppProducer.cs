using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Resolvers;
using System.Xml;
using System.Xml.Linq;

//using System.Windows.Forms;
using System.Xml.Xsl;
using System.IO;
using System.Web;

namespace ICPMD.Modules
{
    class WP8AppProducer
    {
        static string default_page = "";
        
        public static void resources_converter(string path, string project_name)
        {
            string project_path = path;
            //----------- copy assets folder --------------------------------------------
            //----------- copy application icon -----------------------------------------
            try
            {
                // create folder if not exist
                bool isExists = System.IO.Directory.Exists(project_path + "\\WP8\\" + project_name + "\\Assets");
                if (!isExists)
                    System.IO.Directory.CreateDirectory(project_path + "\\WP8\\" + project_name + "\\Assets");
                foreach (string f in Directory.GetFiles(project_path + "\\Abstract\\" + project_name + "\\Assets"))
                {
                    File.Copy(f, project_path + "\\WP8\\" + project_name + "\\Assets\\" + f.Substring(f.LastIndexOf("\\")).ToLower());
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
            //----------- copy tiles -----------------------------------------
            try
            {
                // create folder if not exist
                bool isExists = System.IO.Directory.Exists(project_path + "\\WP8\\" + project_name + "\\Assets\\Tiles");
                if (!isExists)
                    System.IO.Directory.CreateDirectory(project_path + "\\WP8\\" + project_name + "\\Assets\\Tiles");
                foreach (string f in Directory.GetFiles(HttpContext.Current.Server.MapPath("~/ProjectFiles/WP8/Assets/Tiles")))
                {
                    File.Copy(f, project_path + "\\WP8\\" + project_name + "\\Assets\\Tiles\\" + f.Substring(f.LastIndexOf("\\")));
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
            //----------- copy background image -----------------------------------------
            try
            {
                // create folder if not exist
                bool isExists = System.IO.Directory.Exists(project_path + "\\WP8\\" + project_name + "\\Assets");
                if (!isExists)
                    System.IO.Directory.CreateDirectory(project_path + "\\WP8\\" + project_name + "\\Assets");
                foreach (string f in Directory.GetFiles(HttpContext.Current.Server.MapPath("~/ProjectFiles/WP8/Assets")))
                {
                    File.Copy(f, project_path + "\\WP8\\" + project_name + "\\Assets\\" + f.Substring(f.LastIndexOf("\\")));
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
                bool isExists = System.IO.Directory.Exists(project_path + "\\WP8\\" + project_name + "\\Assets\\Sound");
                if (!isExists)
                    System.IO.Directory.CreateDirectory(project_path + "\\WP8\\" + project_name + "\\Assets\\Sound");

                foreach (string f in Directory.GetFiles(project_path + "\\Abstract\\" + project_name + "\\Assets\\Sound"))
                {
                   
                    File.Copy(f, project_path + "\\WP8\\" + project_name + "\\Assets\\Sound\\" + f.Substring(f.LastIndexOf("\\")).ToLower());
                }        
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
            //----------- copy functions file -------------------------------------------
            ////try
            ////{
            ////bool isExists1 = System.IO.Directory.Exists(project_path + "\\WP8\\" + project_name + "\\ICPMD");
            ////if (!isExists1)
            ////    System.IO.Directory.CreateDirectory(project_path + "\\WP8\\" + project_name + "\\ICPMD");

            ////foreach (string f in Directory.GetFiles(@"ProjectFiles\\WP8\\components"))
            ////{
            ////    //--------- update namespace ------------------------------------------------------------
            ////    string comPath = project_path + "\\WP8\\" + project_name + "\\ICPMD\\" + f.Substring(f.LastIndexOf("\\")).ToLower();
            ////    string[] flines = File.ReadAllLines(f);
            ////    for (int x = 0; x < flines.Length; x++)
            ////    {
            ////        if (flines[x].Trim() == "namespace PhoneApp3.ICPMD")
            ////        {
            ////            flines[x] = "namespace "+project_name+".ICPMD";
            ////        }
            ////    }
            ////    File.WriteAllLines(comPath, flines);
            ////    //---------------------------------------------------------------------------------------
            ////    //File.Copy(f, project_path + "\\WP8\\" + project_name + "\\ICPMD\\" + f.Substring(f.LastIndexOf("\\")).ToLower());
            ////}
            //////File.Copy(@"ProjectFiles\Android\functions.java", project_path + "\\Android\\" + project_name + "\\src\\edu\\icpmd\\functions.java");              
            ////}
            ////catch (Exception ex)
            ////{
            ////    Console.WriteLine(ex.Message);
            ////}
            //----------- copy project files --------------------------------------------
            try
            {
                // create folder if not exist
                bool isExists2 = System.IO.Directory.Exists(project_path + "\\WP8\\" + project_name);
                if (!isExists2)
                    System.IO.Directory.CreateDirectory(project_path + "\\WP8\\" + project_name);

                //File.Copy(@"ProjectFiles\WP8\App.xaml", project_path + "\\WP8\\" + project_name + "\\--App.xaml");
                //File.Copy(@"ProjectFiles\WP8\App.xaml.cs", project_path + "\\WP8\\" + project_name + "\\App.xaml.cs");
                //File.Copy(@"ProjectFiles\WP8\LocalizedStrings.cs", project_path + "\\WP8\\" + project_name + "\\LocalizedStrings.cs");
                //File.Copy(@"ProjectFiles\WP8\project.csproj", project_path + "\\WP8\\" + project_name + "\\--" + project_name + ".csproj");

                isExists2 = System.IO.Directory.Exists(project_path + "\\WP8\\" + project_name + "\\Properties");
                if (!isExists2)
                    System.IO.Directory.CreateDirectory(project_path + "\\WP8\\" + project_name + "\\Properties");

                File.Copy(HttpContext.Current.Server.MapPath("~/ProjectFiles/WP8/Properties/AppManifest.xml"), project_path + "\\WP8\\" + project_name + "\\Properties\\AppManifest.xml");
               // File.Copy(@"ProjectFiles\WP8\Properties\AssemblyInfo.cs", project_path + "\\WP8\\" + project_name + "\\Properties\\AssemblyInfo.cs");
                isExists2 = System.IO.Directory.Exists(project_path + "\\WP8\\" + project_name + "\\Resources");
                if (!isExists2)
                    System.IO.Directory.CreateDirectory(project_path + "\\WP8\\" + project_name + "\\Resources");          
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }

            //------------------------- update \Resources\AppResources.Designer.cs ------------------------------------------
            string filePath = project_path + "\\WP8\\" + project_name + "\\Resources\\AppResources.Designer.cs";
            string[] lines = File.ReadAllLines(HttpContext.Current.Server.MapPath("~/ProjectFiles/WP8/Resources/AppResources.Designer.cs"));
            for (int x = 0; x < lines.Length; x++)
            {
                if (lines[x].Trim() == "namespace PhoneApp3.Resources")
                {
                    lines[x] = "namespace "+project_name+".Resources";
                }

                if (lines[x].Trim() == "global::System.Resources.ResourceManager temp = new global::System.Resources.ResourceManager(\"PhoneApp3.Resources.AppResources\", typeof(AppResources).Assembly);")
                {
                    lines[x] = "global::System.Resources.ResourceManager temp = new global::System.Resources.ResourceManager(\""+project_name+".Resources.AppResources\", typeof(AppResources).Assembly);";
                }
            }
            File.WriteAllLines(filePath, lines);
            //--------------------- update \Resources\AppResources.resx ------------------------------------------
            XmlDocument doc = new XmlDocument();
            doc.Load(HttpContext.Current.Server.MapPath("~/ProjectFiles/WP8/Resources/AppResources.resx"));
            XmlElement elmRoot = doc.DocumentElement;
            XmlNamespaceManager namespaceManager = new XmlNamespaceManager(doc.NameTable);
            string xPath = "/Application";//"//Application";  //"//projectDescription//name";
            XmlNode findnode = doc.SelectSingleNode(xPath, namespaceManager);
            findnode = elmRoot.GetElementsByTagName("data").Item(2);
            
            try
            {
               //-------uncomment------------------- findnode.InnerXml = "<value>" + app_title + "</value>";
                //findnode.InnerText = "";
            }
            catch
            {
                //MessageBox.Show(xPath);
            }
            doc.Save(project_path + "\\WP8\\" + project_name + "\\Resources\\AppResources.resx");
            //-------------------------add the name project name element to the xml files ---------------------------
            
            //------------------------- update \Properties\AssemblyInfo.cs ------------------------------------------
            filePath = project_path + "\\WP8\\" + project_name + "\\Properties\\AssemblyInfo.cs";
            lines = File.ReadAllLines(HttpContext.Current.Server.MapPath("~/ProjectFiles/WP8/Properties/AssemblyInfo.cs"));
            //---get the Application Guid from the manifest
            XmlDocument xdoc = new XmlDocument();
            string xmlpath = project_path + "\\Abstract\\" + project_name + "\\Manifest\\manifest.xml";
            xdoc.Load(xmlpath);
            XmlNode node = xdoc.SelectSingleNode("/application/appinfo/productID");

            string guid_temp = node.InnerText.Replace("{", "");
            guid_temp = guid_temp.Replace("}", "");

            for (int x = 0; x < lines.Length; x++)
            {
                if (lines[x].Trim() == "[assembly: AssemblyTitle(\"PhoneApp3\")]")
                {
                    lines[x] = "[assembly: AssemblyTitle(\""+project_name+"\")]";                  
                }

                if (lines[x].Trim() == "[assembly: AssemblyProduct(\"PhoneApp3\")]")
                {
                    lines[x] = "[assembly: AssemblyProduct(\"" + project_name + "\")]";
                }
                
                if (lines[x].Trim() == "[assembly: Guid(\"\")]")
                {
                    lines[x] = "[assembly: Guid(\"" + guid_temp + "\")]";
                    //-------uncomment------------------- lines[x] =  "[assembly: Guid(\""+app_guid+"\")]";
                }
            }
            File.WriteAllLines(filePath,lines);
           
            //------------------------- update \Properties\App.xaml.cs ------------------------------------------
            filePath = project_path + "\\WP8\\" + project_name + "\\App.xaml.cs";
            lines = File.ReadAllLines(HttpContext.Current.Server.MapPath("~/ProjectFiles/WP8/App.xaml.cs"));
            for (int x = 0; x < lines.Length; x++)
            {
                if (lines[x].Trim() == "using PhoneApp3.Resources;")
                {
                    lines[x] = "using " + project_name + ".Resources;";
                }

                if (lines[x].Trim() == "namespace PhoneApp3")
                {
                    lines[x] = "namespace " + project_name;
                }
            }
            File.WriteAllLines(filePath, lines);

            //------------------------- update \LocalizedStrings.cs ------------------------------------------
            filePath = project_path + "\\WP8\\" + project_name + "\\LocalizedStrings.cs";
            lines = File.ReadAllLines(HttpContext.Current.Server.MapPath("~/ProjectFiles/WP8/LocalizedStrings.cs"));
            for (int x = 0; x < lines.Length; x++)
            {
                if (lines[x].Trim() == "using PhoneApp3.Resources;")
                {
                    lines[x] = "using "+project_name+".Resources;" ;
                }

                if (lines[x].Trim() == "namespace PhoneApp3")
                {
                    lines[x] = "namespace " + project_name ;
                }
            }
            File.WriteAllLines(filePath, lines);
            
            //-----------------------------------------------------------------------
            doc = new XmlDocument();
            doc.Load(HttpContext.Current.Server.MapPath("~/ProjectFiles/WP8/App.xaml"));
            //doc.NamespaceURI
            //using (XmlTextReader tr = new XmlTextReader(@"ProjectFiles\WP8\App.xaml"))
            //{
            //    tr.Namespaces = false;
            //    doc.Load(tr);
            //}
            elmRoot = doc.DocumentElement;
            namespaceManager = new XmlNamespaceManager(doc.NameTable);
            //XmlNode spanNode;
            //-------- seach for pageinitializer ---------------------------------
            //string id = "InitializeComponent";
            xPath = "/Application";//"//Application";  //"//projectDescription//name";
            findnode = doc.SelectSingleNode(xPath, namespaceManager);
            try
            {
                elmRoot.SetAttribute("x:Class", project_name + ".App");
                //foreach (XmlNode node in findnode)
                //{
                //XmlNode 
                //spanNode = doc.CreateElement("namespace", project_name);
                //MessageBox.Show(node.ParentNode.ParentNode.ParentNode.OuterXml);
                ////////////////////////////////////////////findnode.InnerText = project_name; //.ReplaceChild(spanNode);
                //--------------------findnode.Attributes["x:Class"].Value = project_name + ".App"; //x:Class
                //}
            }
            catch
            {
                //MessageBox.Show(xPath);
            }

            //------------xPath = "/Application/Application.Resources";//LocalizedStrings"; //; //"//projectDescription//name";
            //------------findnode = doc.SelectSingleNode(xPath, namespaceManager);

            findnode= elmRoot.GetElementsByTagName("Application.Resources").Item(0);

            try
            {
                findnode.InnerXml = "<local:LocalizedStrings xmlns:local=\"clr-namespace:"+project_name+"\"  x:Key=\"LocalizedStrings\" />";
                //findnode.Attributes["xmlns:local"].Value = "clr-namespace:"+project_name ;
            }
            catch
            {
                //MessageBox.Show(xPath);
            }
            doc.Save(project_path + "\\WP8\\" + project_name + "\\App.xaml");
            //----------------------------update the project.csproj file -------------------------------------------
            doc = new XmlDocument();
            doc.Load(HttpContext.Current.Server.MapPath("~/ProjectFiles/WP8/project.csproj"));
            //using (XmlTextReader tr = new XmlTextReader(@"ProjectFiles\WP8\project.csproj"))
            //{
                //tr.Namespaces = false;
              //  tr.Namespaces = true;
              //  doc.Load(tr);
            //}
            XmlElement elmRoot1 = doc.DocumentElement;
            XmlNamespaceManager namespaceManager1 = new XmlNamespaceManager(doc.NameTable);
            //XmlNode spanNode;
            //-------- seach for pageinitializer ---------------------------------
            //string id = "InitializeComponent";
            string xPath1 = "/PropertyGroup"; //"//Project//PropertyGroup";  //"//projectDescription//name";
            //XmlNode findnode1 = elmRoot1.SelectSingleNode(xPath1, namespaceManager);
            XmlNode findnode1 = elmRoot1.GetElementsByTagName("PropertyGroup").Item(0); //SelectSingleNode(xPath1, namespaceManager);
            try
            {
                findnode1.ChildNodes[4].InnerText  = ""; //<ProjectGuid>GUID  of application
                findnode1.ChildNodes[8].InnerText  = project_name; //RootNamespace
                findnode1.ChildNodes[9].InnerText  = project_name; //AssemblyName
                findnode1.ChildNodes[17].InnerText = project_name + "_$(Configuration)_$(Platform).xap"; //XapFilename
                findnode1.ChildNodes[19].InnerText = project_name + ".App"; //SilverlightAppEntry
            }
             catch
            {
                //MessageBox.Show(xPath);
            }

            xPath = "//Project//ItemGroup";//"//projectDescription//name";

            findnode1 = elmRoot1.GetElementsByTagName("ItemGroup").Item(0);

            //---------------findnode1 = doc.SelectSingleNode(xPath, namespaceManager);
            //--- get default page --
            ////////////////string temp1="";//-------uncomment-------------------= pages[default_page];
            //////////////string[] temp2 = temp1.Split(';');
            try
            {
                XmlNode n = doc.CreateElement("Compile", doc.DocumentElement.NamespaceURI);              
                XmlAttribute a = doc.CreateAttribute("Include");
               // a.Value = temp2[0] + ".xaml.cs";
                a.Value = default_page+ ".cs";
                n.Attributes.Append(a);
                //n.InnerXml= "<DependentUpon>"+temp2[0]+".xaml</DependentUpon>";
                //n.InnerXml = "<DependentUpon>" + default_page + "</DependentUpon>";
                XmlElement n1 = doc.CreateElement("DependentUpon", doc.DocumentElement.NamespaceURI);
                n1.InnerText = default_page;
                n.AppendChild(n1);
                
                findnode1.AppendChild(n);
            }
            catch
            {
                //MessageBox.Show(xPath);
            }
            xPath = "//Project//ItemGroup//Page";//"//projectDescription//name";

            findnode1 = ((XmlElement) elmRoot1.GetElementsByTagName("ItemGroup").Item(1)).GetElementsByTagName("Page").Item(0);
            //findnode1 = doc.SelectSingleNode(xPath, namespaceManager);
            try
            {
                //findnode1.Attributes["Include"].Value = temp2[0] + ".xaml";
                findnode1.Attributes["Include"].Value = default_page;// +".xaml";
                findnode1.Attributes.Remove(findnode1.Attributes["xmlns"]);
                
            }
            catch
            {
                //MessageBox.Show(xPath);
            }
            //register all images inthe abstract/assets folder in the .csproj file
            try
            {
                // create folder if not exist
                foreach (string f in Directory.GetFiles(project_path + "\\Abstract\\" + project_name + "\\Assets"))
                {
                    findnode1 = ((XmlElement)elmRoot1.GetElementsByTagName("ItemGroup").Item(3));//.GetElementsByTagName("Content").Item(0);
                    //findnode1 = doc.SelectSingleNode(xPath, namespaceManager);

                    XmlElement n = doc.CreateElement("Content", doc.DocumentElement.NamespaceURI);
                    XmlAttribute a = doc.CreateAttribute("Include");
                    a.Value = "Assets\\" +   f.Substring(f.LastIndexOf("\\")+1);
                    n.Attributes.Append(a);
                    //n.InnerXml = " <CopyToOutputDirectory>PreserveNewest</CopyToOutputDirectory>";
                    XmlElement n1 = doc.CreateElement("CopyToOutputDirectory", doc.DocumentElement.NamespaceURI);
                    n1.InnerText = "PreserveNewest";
                    n.AppendChild(n1);
                    findnode1.AppendChild(n);
                    
                    
                    
                    //XElement mm = new XElement("Content", new XAttribute("Include", f.Substring(f.LastIndexOf("\\"))));
                   
                        //findnode1.Attributes["Include"].Value = temp2[0] + ".xaml";
                        ///////////findnode1.Attributes["Include"].Value = app_icon;// +".xaml";
                        //findnode1.Attributes.Remove(findnode1.Attributes["xmlns"]);

                   //File.Copy(f, project_path + "\\WP8\\" + project_name + "\\Assets\\" + f.Substring(f.LastIndexOf("\\")).ToLower());
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }


           

            doc.Save(project_path + "\\WP8\\" + project_name + "\\" + project_name + ".csproj");
        }
        /// <summary>
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// </summary>
        public static void manifest_converter(string path, string project_name)
        {
            string project_path = path;
            string xmlPath = project_path + "\\Abstract\\" + project_name + "\\Manifest\\manifest.xml";
            string xslPath = HttpContext.Current.Server.MapPath("~/XSLT/") + "\\AM_to_WP8_Manifest.xslt";
            string resultPath = project_path + "\\WP8\\" + project_name + "\\Properties\\WMAppManifest.xml";

            //XmlReader loads XML file
            XmlReader reader = XmlReader.Create(xmlPath);
            XmlReader reader1 = XmlReader.Create(xmlPath);
            
            //------------------------------------------
            while (reader1.Read())
            {
                if ((reader1.NodeType == XmlNodeType.Element) && (reader1.Name == "defaultpage"))
                {
                    default_page = reader1.ReadInnerXml() ;
                }
            }

            //------------------------------------------
            // create folder if not exist
            bool isExists = System.IO.Directory.Exists(project_path + "\\WP8\\" + project_name);
            if (!isExists)
                System.IO.Directory.CreateDirectory(project_path + "\\WP8\\" + project_name + "\\Properties\\");

            //XmlTextWriter creats output file
            XmlTextWriter writer = new XmlTextWriter(resultPath, null);

            //XslCompiledTransform loads XSLT file
            XslCompiledTransform xsl = new XslCompiledTransform();
            xsl.Load(xslPath);
            xsl.Transform(reader, writer);
            writer.Close();
            //textBox2.Text = File.ReadAllText(project_path + "\\Abstract\\Manifest\\manifest.xml");

        }

        public static void ui_converter(string path , string project_name)
        {
            string project_path=path;
            foreach (string f in Directory.GetFiles(project_path + "\\Abstract\\" + project_name + "\\UI"))
                if (f.EndsWith(".xml"))
                {
                    String file_name = f.Substring(f.LastIndexOf("\\"));
                    string xmlPath = project_path + "\\Abstract\\" + project_name + "\\UI\\" + file_name;
                    string xslPath = HttpContext.Current.Server.MapPath("~/XSLT/") + "\\AM_to_WP8_UI.xslt";
                    file_name = file_name.Substring(1, file_name.IndexOf(".") - 1);
                    string resultPath = project_path + "\\WP8\\" + project_name + "\\" + file_name.ToLower() + ".xaml";
                    //string new_page_name = "";


                    //XmlReader loads XML file
                    XmlReader reader = XmlReader.Create(xmlPath);

                    // create folder if not exist
                    bool isExists = System.IO.Directory.Exists(project_path + "\\WP8\\" + project_name +"");
                    if (!isExists)
                        System.IO.Directory.CreateDirectory(project_path + "\\WP8\\" + project_name +"");

                    //XmlTextWriter creats output file
                    XmlTextWriter writer = new XmlTextWriter(resultPath, null);

                    //XslCompiledTransform loads XSLT file
                    XslCompiledTransform xsl = new XslCompiledTransform();
                    xsl.Load(xslPath);
                    //xsl.Transform(reader, xsl.OutputSettings , writer);
                    //new code
                    //MessageBox.Show(xsl.OutputSettings.OmitXmlDeclaration.ToString());
                    //XmlWriterSettings settings =  xsl.OutputSettings;
                    //XmlWriter writer1 = XmlWriter.Create(resultPath, settings);

                    // Execute the transformation.
                    xsl.Transform(reader, writer);
                    //end new code
                    writer.Close();

                    
                    //textBox2.Text = File.ReadAllText(project_path + "\\Abstract\\Manifest\\manifest.xml");
                    XmlDocument xdoc = new XmlDocument();
                    //string xmlpath = project_path + "\\Abstract\\" + project_name + "\\Manifest\\manifest.xml";
                    xdoc.Load(resultPath);

                    XmlNamespaceManager nsmgr = new XmlNamespaceManager(xdoc.NameTable);
                    nsmgr.AddNamespace("phone", "clr-namespace:Microsoft.Phone.Controls;assembly=Microsoft.Phone");

                    XmlNode node = xdoc.SelectSingleNode("/phone:PhoneApplicationPage", nsmgr);
                    node.Attributes["x:Class"].Value = project_name + "." + file_name;
                    xdoc.Save(resultPath);
                }

        }

        public static void code_parser(string ast_file_name,string path,string project_name)
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
                    //MessageBox.Show(prdName.ToString());
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
                    //MessageBox.Show(prdName.ToString());

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
   


     public static void code_generator(string path,string project_name)
        {
            string project_path = path;
            foreach (string f in Directory.GetFiles(project_path + "\\Abstract\\" + project_name + "\\Code"))
                if (f.EndsWith(".xml"))
                {
                    String file_name = f.Substring(f.LastIndexOf("\\"));
                    string xmlPath = project_path + "\\Abstract\\" + project_name + "\\Code\\" + file_name;
                    string xslPath = HttpContext.Current.Server.MapPath("~/XSLT/csharp_code_generator.xslt");
                    file_name = file_name.Substring(1, file_name.IndexOf(".") - 1);
                    string resultPath = project_path + "\\WP8\\" + project_name + "\\" + file_name + ".xaml.cs";

                    //XmlReader loads XML file
                    XmlReader reader = XmlReader.Create(xmlPath);

                    // create folder if not exist
                    bool isExists = System.IO.Directory.Exists(project_path + "\\WP8\\" + project_name + "\\");
                    if (!isExists)
                        System.IO.Directory.CreateDirectory(project_path + "\\WP8\\" + project_name + "\\");

                    //XmlTextWriter creats output file
                    XmlTextWriter writer = new XmlTextWriter(resultPath, null);

                    //XslCompiledTransform loads XSLT file
                    string fname;
                    fname = project_path + "\\WP8\\" + project_name + "\\" + file_name.ToLower() + ".xaml";
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
    

