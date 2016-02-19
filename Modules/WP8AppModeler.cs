using System;
using System.Collections.Generic;
using System.Linq; 
using System.Text;
using System.Xml;
using System.Xml.Linq;
//using System.Windows.Forms;
using System.Xml.Xsl;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.OleDb;
using System.Text.RegularExpressions;
using System.Collections;
namespace ICPMD.Modules
{
    class WP8AppModeler
    {        
        static string ConvertStringArrayToString(string[] array)
        {  
            // Concatenate all the elements into a StringBuilder.
            StringBuilder builder = new StringBuilder();
            foreach (string value in array)
            {
                builder.Append(value);
                builder.Append(Environment.NewLine);
            }
            return builder.ToString();
        }
        
        public static void resources_converter(string path, string project_name)
        {
            string target_path = path;
            string source_path = path + "\\Source\\" + project_name;
            try
            {
                // create folder if not exist
                bool isExists = System.IO.Directory.Exists(target_path + "\\Abstract\\" + project_name + "\\Assets");
                if (!isExists)
                    System.IO.Directory.CreateDirectory(target_path + "\\Abstract\\" + project_name + "\\Assets");
                isExists = System.IO.Directory.Exists(source_path + "\\Assets");
                if (isExists)
                {
                foreach (string f in Directory.GetFiles(source_path+"\\Assets"))
                   {
                    File.Copy(f, target_path + "\\Abstract\\" + project_name + "\\Assets\\" + f.Substring(f.LastIndexOf("\\")));

                }
                        foreach (string d in Directory.GetDirectories(source_path + "\\Assets"))
                        {
                            isExists = System.IO.Directory.Exists(target_path + "\\Abstract\\" + project_name + "\\Assets\\" + d.Substring(d.LastIndexOf("\\")));
                            if (!isExists)
                                System.IO.Directory.CreateDirectory(target_path + "\\Abstract\\" + project_name + "\\Assets\\" + d.Substring(d.LastIndexOf("\\")));

                            foreach (string f1 in Directory.GetFiles(d))
                            {
                                File.Copy(f1, target_path + "\\Abstract\\" + project_name + "\\Assets\\" + d.Substring(d.LastIndexOf("\\")) + "\\" + f1.Substring(f1.LastIndexOf("\\")));
                            }
                        }
                    }
                //}

                foreach (string f in Directory.GetFiles(source_path + ""))
                {
                    if (f.EndsWith(".png") || f.EndsWith(".jpg"))
                    {
                        //isExists = System.IO.Directory.Exists(target_path + "\\Abstract\\" + project_name + "\\Assets\\" + f.Substring(f.LastIndexOf("\\")));
                        //if (!isExists)
                        File.Copy(f, target_path + "\\Abstract\\" + project_name + "\\Assets\\" + f.Substring(f.LastIndexOf("\\")),true);
                    }
                }

                foreach (string d1 in Directory.GetDirectories(source_path + ""))
                {
                    foreach (string f2 in Directory.GetFiles(d1))
                    {
                        if (f2.EndsWith(".png") || f2.EndsWith(".jpg"))
                        {
                            //isExists = System.IO.Directory.Exists(target_path + "\\Abstract\\" + project_name + "\\Assets\\" + d1.Substring(d1.LastIndexOf("\\")) + "\\" + f2.Substring(f2.LastIndexOf("\\")));
                            //if (!isExists)
                            File.Copy(f2, target_path + "Abstract\\" + project_name + "\\Assets\\"  + f2.Substring(f2.LastIndexOf("\\")),true);
                        }
                    }
                }
              
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
        }

        public static void manifest_converter(string path, string project_name)
        {
            string target_path = path;
            string source_path = path + "\\Source\\" + project_name;
            string xmlPath = source_path + "\\Properties\\WMAppManifest.xml";
            string xslPath = HttpContext.Current.Server.MapPath("~/XSLT/") + "\\WP_to_AM_Manifest.xslt";
            string resultPath = target_path + "\\Abstract\\" + project_name + "\\Manifest\\manifest_temp.xml";

            //XmlReader loads XML file
            XmlReader reader = XmlReader.Create(xmlPath);

            // create folder if not exist
            bool isExists = System.IO.Directory.Exists(target_path + "\\Abstract\\" + project_name + "\\Manifest");
            if (!isExists)
                System.IO.Directory.CreateDirectory(target_path + "\\Abstract\\" + project_name + "\\Manifest");

            //XmlTextWriter creats output file
            XmlTextWriter writer = new XmlTextWriter(resultPath, null);

            //XslCompiledTransform loads XSLT file
            XslCompiledTransform xsl = new XslCompiledTransform();
            xsl.Load(xslPath);
            xsl.Transform(reader, writer);
            writer.Close();
            //-------------------------add the name space element to the xml file ---------------------------
            XmlDocument doc = new XmlDocument();
            using (XmlTextReader tr = new XmlTextReader(resultPath))
            {
                tr.Namespaces = false;
                doc.Load(tr);
            }
            XmlElement elmRoot = doc.DocumentElement;
            XmlNamespaceManager namespaceManager = new XmlNamespaceManager(doc.NameTable);
            XmlNode spanNode;
            //-------- seach for pageinitializer ---------------------------------
            //string id = "InitializeComponent";
            string xPath = "//appinfo";
            XmlNodeList findnode = doc.SelectNodes(xPath, namespaceManager);
            try
            {
                foreach (XmlNode node in findnode)
                {
                    //XmlNode 
                    spanNode = doc.CreateElement("namespace");
                    spanNode.InnerText = project_name;
                    //////////spanNode = doc.CreateElement("namespace",Default.project_name);
                    //MessageBox.Show(node.ParentNode.ParentNode.ParentNode.OuterXml);
                    node.AppendChild(spanNode);
                }

                //----------- add other pages to the manifest ------------------------------
                foreach (string f in Directory.GetFiles(source_path))
                {
                    if (f.EndsWith(".xaml"))
                    {
                        if (f.EndsWith("App.xaml"))
                        {
                        }
                        else
                        {
                            string file_name = f.Substring(f.LastIndexOf("\\")+1);
                            string defaultpage = "";
                            string xPath1 = "//appinfo//pages//defaultpage";
                            XmlNodeList findnode1 = doc.SelectNodes(xPath1, namespaceManager);

                            foreach (XmlNode node in findnode1)
                            {
                                defaultpage = node.InnerText;
                            }

                             xPath1 = "//appinfo//pages";
                             findnode1 = doc.SelectNodes(xPath1, namespaceManager);

                            foreach (XmlNode node in findnode1)
                            { 
                                if (file_name.Equals(defaultpage)==false)
                                {
                                spanNode = doc.CreateElement("page");
                                spanNode.InnerText = file_name;
                                node.AppendChild(spanNode);
                                }
                            }
                        }

                    }
                }

                //--------------------------------------------------------------------------
            }
            catch
            {
                //MessageBox.Show(xPath);
            }


            doc.Save(target_path + "\\Abstract\\" + project_name + "\\Manifest\\manifest.xml");

            //-----------------------------------------------------------------------------------------------
            //textBox2.Text = File.ReadAllText(Default.target_path + "\\Abstract\\Manifest\\manifest.xml");

        }

        public static void ui_converter(string path, string project_name)
        {
            string target_path = path;
            string source_path = path + "\\Source\\" + project_name; 
            foreach (string f in Directory.GetFiles(source_path))
                if (f.EndsWith(".xaml"))
                {
                    if (f.EndsWith("App.xaml"))
                    { 
                    
                    }
                    else
                    {
                        string file_name = f.Substring(f.LastIndexOf("\\"));
                        string xmlPath = source_path + "\\" + file_name;
                        string xslPath = HttpContext.Current.Server.MapPath("~/XSLT/") + "\\WP_to_AM_UI.xslt";
                        file_name = file_name.Substring(1, file_name.IndexOf(".") - 1);
                        string resultPath = target_path + "\\Abstract\\" + project_name + "\\UI\\" + file_name + ".xml";

                        //XmlReader loads XML file
                        XmlReader reader = XmlReader.Create(xmlPath);

                        // create folder if not exist
                        bool isExists = System.IO.Directory.Exists(target_path + "\\Abstract\\" + project_name + "\\UI");
                        if (!isExists)
                            System.IO.Directory.CreateDirectory(target_path + "\\Abstract\\" + project_name + "\\UI");

                        //XmlTextWriter creats output file
                        XmlTextWriter writer = new XmlTextWriter(resultPath, null);

                        //XslCompiledTransform loads XSLT file
                        XslCompiledTransform xsl = new XslCompiledTransform();
                        xsl.Load(xslPath);
                        xsl.Transform(reader, writer);
                        writer.Close();
                        //---------------- generate the Menu file --------------------------------------------
                        xslPath = HttpContext.Current.Server.MapPath("~/XSLT/") + "\\WP_to_AM_Menu.xslt";
                        resultPath = target_path + "\\Abstract\\" + project_name + "\\Menu\\" + file_name + ".xml";

                        //XmlReader loads XML file
                        reader = XmlReader.Create(xmlPath);

                        // create folder if not exist
                        isExists = System.IO.Directory.Exists(target_path + "\\Abstract\\" + project_name + "\\Menu");
                        if (!isExists)
                            System.IO.Directory.CreateDirectory(target_path + "\\Abstract\\" + project_name + "\\Menu");

                        //XmlTextWriter creats output file
                        writer = new XmlTextWriter(resultPath, null);

                        //XslCompiledTransform loads XSLT file
                        xsl = new XslCompiledTransform();
                        xsl.Load(xslPath);
                        xsl.Transform(reader, writer);
                        writer.Close();
                    }
                }
        }

        public static string update_string(string strin)
        {
            string strout = strin;
            strout = strout.Replace("&", "&amp;");
            strout = strout.Replace("<", "&lt;");
            strout = strout.Replace(">", "&gt;");
            strout = strout.Replace("\"", "&quot;");
            strout = strout.Replace("'", "&apos;");
            return strout;
        }

        public static void code_parser(string path, string project_name,string filename)
        {//string source_file_name,
        
            string target_path = path;
            
            string source_path = path + "\\Source\\" + project_name;
            if (filename.Equals("") == false)
            {
                 algorithm(source_path, target_path,project_name,filename);
            }
            else
            {
            foreach (string f in Directory.GetFiles(source_path))
            {
                if (f.EndsWith(".xaml.cs"))
                {
                    if (f.EndsWith("App.xaml.cs"))
                    {
                        
                    }
                    else
                    {
                        string file_name = f.Substring(f.LastIndexOf("\\"));
                        algorithm(source_path, target_path, project_name, file_name);
                    }

                }
        }}
        }

        public static void algorithm(string source_path, string target_path, string project_name, string file_name)
        {
            string pageclass = "";
            int lines_of_code, converted, unconverted;
            converted = 0;
            string[] lines,lines_type,raw_lines;
            int[] lines_pattern_id, lines_pattern_step, lines_pattern_total,other_method_id;
            string[] temp_regex, temp_android,lines_pattern_name;
            List<string> method_to_class = new List<string>();
            Stack myStack = new Stack();
            var tagname = "";
            string filePath = source_path + "\\" + file_name;
            if (file_name.StartsWith("\\"))
            {
                        file_name = file_name.Substring(1, file_name.IndexOf(".") - 1);
            }
            else
            {
                file_name = file_name.Substring(0, file_name.IndexOf(".") );
            }
                        string resultPath = target_path + "\\Abstract\\" + project_name + "\\Code\\" + file_name + ".xml";
                        
                        //--- define source code and algorithm survey results arrays

                        
                        raw_lines = File.ReadAllLines(filePath);
                        List<string> updated_lines = new List<string>();
                        int loc = raw_lines.Length;
                        //------------ code preparation phase -----------------------------------------------------------
                        for (int xx = 0; xx < raw_lines.Length; xx++)
                        {
                            if ((raw_lines[xx].Trim().StartsWith("}")) && (raw_lines[xx].Trim().Length > 1))
                            {
                                string[] sp = raw_lines[xx].Split('}');
                                loc = loc + (sp.Length - 1);
                                updated_lines.Add("}");
                                for (int yy = 1; yy < sp.Length; yy++)
                                {
                                    updated_lines.Add(sp[yy]);
                                }
                            }
                            else
                            {
                            updated_lines.Add(raw_lines[xx]);
                            }
                        }
                        //-----------------------------------------------------------------------------------------------
                        //lines = File.ReadAllLines(filePath);
                        lines = new string[loc];
                        for (int zz = 0; zz < loc; zz++)
                        {
                            lines[zz] = updated_lines[zz];
                        }
                        lines_type = new string[lines.Length];
                        lines_pattern_id = new int[lines.Length];
                        lines_pattern_step = new int[lines.Length];
                        lines_pattern_total = new int[lines.Length];
                        temp_regex = new string[lines.Length];
                        temp_android = new string[lines.Length];
                        other_method_id = new int[lines.Length];
                        lines_pattern_name = new string[lines.Length];

                        for (int xx = 0; xx < lines.Length; xx++)
                        {
                            lines_type[xx] = "";
                        }
                         
                        //--- search for composite patterns in the database ---------------------------------------
                        OleDbConnection connection = new OleDbConnection("Provider = Microsoft.Jet.OLEDB.4.0; Data Source = |DataDirectory|\\icpmd.mdb");
                        connection.Open();
                        
                        //-------------------------------------------------
                        OleDbCommand command10 = new OleDbCommand("SELECT id, pattern FROM composite_patterns;", connection);
                        OleDbDataReader reader10 = command10.ExecuteReader();
                        while (reader10.Read() && reader10.HasRows)
                        {
                            int pattern_id = reader10.GetInt32(0);
                            ArrayList templines = new ArrayList();
                            string pattern_name = "";
                            int pattern_index = 1;
                            int statement_count = 0;                          
                            OleDbCommand command11 = new OleDbCommand("SELECT count(*) FROM composite_pattern_statements where pattern_id=" + pattern_id + ";", connection);
                            statement_count = (int) command11.ExecuteScalar();

                            Boolean repeat_pattern = true;
                            while (repeat_pattern)
                            {
                                repeat_pattern = false;
                                Hashtable share = new Hashtable();
                            OleDbCommand command1 = new OleDbCommand("SELECT composite_pattern_statements.statement, composite_pattern_statements.item_id, composite_patterns.pattern, composite_patterns.Count, Component.component, composite_pattern_statements.pattern_id,composite_pattern_statements.android_output,different_method_id FROM (composite_pattern_statements INNER JOIN composite_patterns ON composite_pattern_statements.pattern_id = composite_patterns.ID) LEFT JOIN Component ON composite_patterns.component_id = Component.ID  where composite_patterns.id=" + pattern_id + ";", connection);
                            OleDbDataReader reader5 = command1.ExecuteReader();
                            bool flag2 = false;
                            
                            while (reader5.Read() && reader5.HasRows)
                            {
                                if (reader5.IsDBNull(0) == false)
                                {
                            var pattern_statement_regex = reader5.GetString(0);
                            Hashtable param = new Hashtable();
                            int param_index = 1;
                            if (pattern_statement_regex.Contains("@PARAM"))
                            {
                                foreach (DictionaryEntry pair in param)
                                {
                                   pattern_statement_regex = pattern_statement_regex.Replace(pair.Key.ToString(), pair.Value.ToString());
                                }
                            }
                            if (pattern_statement_regex.Contains("@SHARE"))
                            {
                                foreach (DictionaryEntry pair in share)
                                {
                                    pattern_statement_regex = pattern_statement_regex.Replace(pair.Key.ToString(), pair.Value.ToString());
                                }
                            }                                
                            // Instantiate the regular expression object.
                            Regex rr = new Regex(pattern_statement_regex, RegexOptions.None);

                            // Match the regular expression pattern against a text string.
                            for (int j = 0; j < lines.Length; j++)
                            {
                                Match mm = rr.Match(lines[j]);
                                if (mm.Success &&(lines_type[j].Equals("composite")==false))
                                {
                                    repeat_pattern = true;
                                    temp_regex[j] = pattern_statement_regex;
                                 if (pattern_name.Equals(reader5.GetString(2)))
                                    {
                                        pattern_index = pattern_index + 1;
                                        templines.Add(j);
                                    }
                                    else
                                    {
                                        pattern_name = reader5.GetString(2);
                                        pattern_index = 1;
                                        templines.Add(j);
                                    }
                                    //--------------- extract parameters and update temp_regex -------------------------
                                     for (int x = 1; x < mm.Groups.Count;x++ )
                                     {
                                             param.Add("@PARAM" + param_index, mm.Groups[x].ToString());
                                             param_index = param_index + 1;
                                     }
                                     if (flag2 == false)
                                     {
                                         int share_index = 1;
                                         for (int x = 1; x < mm.Groups.Count; x++)
                                         {
                                             share.Add("@SHARE" + share_index, mm.Groups[x].ToString());
                                             share_index = share_index + 1;

                                            
                                         }
                                         if (mm.Groups.Count > 1)
                                         {
                                             flag2 = true;
                                         }
                                     }
                                     //-------------- update java code -----------------------
                                     if (!reader5.IsDBNull(6))
                                     {
                                         if (!reader5.IsDBNull(7))
                                         {
                                             other_method_id[j] = reader5.GetInt32(7);
                                         }
                                         temp_android[j] = reader5.GetString(6);
                                         if (temp_android[j].Contains("@PARAM"))
                                         {
                                             foreach (DictionaryEntry pair in param)
                                             {
                                                 temp_android[j] = temp_android[j].Replace(pair.Key.ToString(), pair.Value.ToString());
                                             }
                                         }

                                         if (temp_android[j].Contains("@SHARE"))
                                         {
                                             foreach (DictionaryEntry pair in share)
                                             {
                                                 temp_android[j] = temp_android[j].Replace(pair.Key.ToString(), pair.Value.ToString());
                                             }
                                         }
                                     }

                                     //----------------- replace expression patterns ---------------------------------
                                     OleDbCommand command22 = new OleDbCommand("SELECT expression, android_code from expression_patterns order by ID ASC;", connection);
                                     OleDbDataReader reader22 = command22.ExecuteReader();
                                     //Hashtable param22 = new Hashtable();
                                     //              int param22_index=1;
                                     string android22;
                                     if (String.IsNullOrEmpty(temp_android[j]) == false)
                                     {
                                         while (reader22.Read()  )//----------- test expression patterns ---&& reader22.HasRows && (!reader22.IsDBNull(1)))
                                         {
                                             var expression_regex = reader22.GetString(0);
                                             Regex r22 = new Regex(expression_regex, RegexOptions.None);
                                             // Match the regular expression pattern against a text string.
                                             //  for (int b = 0; b < lines.Length; b++)
                                             //  {
                                             Match m22 = r22.Match(temp_android[j]);
                                             if (m22.Success)
                                             {
                                                 android22 = reader22.GetString(1);
                                                 //--------------- extract parameters and update temp_regex ----------------------
                                                 for (int xx = 1; xx < m22.Groups.Count; xx++)
                                                 {
                                                     //param22.Add("@PARAM" + param22_index, m22.Groups[xx].ToString());
                                                     android22 = android22.Replace("@PARAM" + xx, m22.Groups[xx].ToString());
                                                     //param22_index = param22_index + 1;
                                                 }
                                                 temp_android[j] = temp_android[j].Replace(m22.Groups[0].ToString(), android22);
                                             }
                                             //-------------- update java code -----------------------
                                             //-------------------------------------------------------------------------------
                                             //  }
                                         }
                                     }

                                     //-------------------------------------------------------
                                     break;
                                }
                                //-//-//-
                            }
                        }

                        }
                            for (int jj = 0; jj < templines.Count; jj++)
                            {
                                lines_type[(int)templines[jj]] = "composite";
                                lines_pattern_id[(int)templines[jj]] = pattern_id; //reader5.GetInt32(5);
                                lines_pattern_name[(int)templines[jj]] = pattern_name; //reader5.GetInt32(5);                         
                                lines_pattern_step[(int)templines[jj]] = jj + 1;
                                lines_pattern_total[(int)templines[jj]] = statement_count; //.GetInt32(3);
                            }
                        }
        }
            //--------- end of composite pattern check -----------------------------------------------

                        //----------------------------------------------------------------------------------
                        //--- search for simple patterns in the database ---------------------------------------
                        //OleDbConnection connection = new OleDbConnection("Provider = Microsoft.Jet.OLEDB.4.0; Data Source = |DataDirectory|\\icpmd.mdb");
                        //connection.Open();
                        //string pattern_name = "";
                        //int pattern_index = 1;
                        //ArrayList templines = new ArrayList();
                        //-------- check method to class function
                        OleDbCommand command99 = new OleDbCommand("SELECT method_name, statement, android_code_start, android_code_end FROM method_to_class where  approved=true;", connection);// where id =" + strid, connection);
                        OleDbDataReader reader99 = command99.ExecuteReader();
                        while ( reader99.Read() && reader99.HasRows)
                        {
                            Regex r1 = new Regex(reader99.GetString(0), RegexOptions.None);

                            // Match the regular expression pattern against a text string.
                            Match m1;

                            for (int j = 0; j < lines.Length; j++)
                            {
                                m1 = r1.Match(lines[j]);
                                //string android1 = "";
                                //int matchCount = 0;
                                if (m1.Success)
                                {
                                    method_to_class.Add(m1.Groups[1].ToString());

                                }
                            }
                        }

                        OleDbCommand command111 = new OleDbCommand("SELECT  statement,id,android_code FROM simple_patterns;", connection);
                        OleDbDataReader reader555 = command111.ExecuteReader();
                        while (reader555.Read() && reader555.HasRows)
                        {
                            var pattern_statement_regex = reader555.GetString(0);

                            // Instantiate the regular expression object.
                            Regex rr = new Regex(pattern_statement_regex, RegexOptions.None);
                            
                            // Match the regular expression pattern against a text string.
                            for (int j = 0; j < lines.Length; j++)
                            {
                                if (lines_type[j].Equals("composite")==false)
                                {
                                    Match mm = rr.Match(lines[j]);
                                    Hashtable param = new Hashtable();
                                    int param_index = 1;
                                    if (mm.Success)
                                    {                                              
                                        lines_type[j] = "simple";
                                        lines_pattern_id[j] = reader555.GetInt32(1);

                                        //--------------- extract parameters and update temp_regex -------------------------
                                        for (int x = 1; x < mm.Groups.Count; x++)
                                        {
                                            param.Add("@PARAM" + param_index, mm.Groups[x].ToString());
                                            param_index = param_index + 1;
                                        }
                                        //-------------- update java code -----------------------
                                        if (!reader555.IsDBNull(2))
                                        {
                                            temp_android[j] = reader555.GetString(2);
                                            if (temp_android[j].Contains("@PARAM"))
                                            {
                                                foreach (DictionaryEntry pair in param)
                                                {
                                                    temp_android[j] = temp_android[j].Replace(pair.Key.ToString(), pair.Value.ToString());
                                                }
                                            }

                                            //----------------- replace expression patterns ---------------------------------
                                            OleDbCommand command22 = new OleDbCommand("SELECT expression, android_code from expression_patterns order by ID ASC;", connection);
                                            OleDbDataReader reader22 = command22.ExecuteReader();
                                            //Hashtable param22 = new Hashtable();
                                            //              int param22_index=1;
                                            string android22;
                                            while (reader22.Read() ) //----------------&& reader22.HasRows && (!reader22.IsDBNull(0)))
                                            {
                                                var expression_regex = reader22.GetString(0);
                                                Regex r22 = new Regex(expression_regex, RegexOptions.None);
                                              // Match the regular expression pattern against a text string.
                                              //  for (int b = 0; b < lines.Length; b++)
                                              //  {
                                                    Match m22 = r22.Match(temp_android[j]);
                                                    if (m22.Success)
                                                    {
                                                        android22 = reader22.GetString(1);
                                                        //--------------- extract parameters and update temp_regex ----------------------
                                                        for (int xx = 1; xx < m22.Groups.Count; xx++)
                                                        {
                                                            //param22.Add("@PARAM" + param22_index, m22.Groups[xx].ToString());
                                                          android22 =  android22.Replace("@PARAM" + xx, m22.Groups[xx].ToString());
                                                            //param22_index = param22_index + 1;
                                                        }
                                                       temp_android[j] = temp_android[j].Replace(m22.Groups[0].ToString(), android22);
                                                    }
                                                    //-------------- update java code -----------------------
                                                    //-------------------------------------------------------------------------------
                                              //  }
                                            }
                                        }
                                     //-------------------------------------------------------------------------------  
                                    }
                                }
                            }
                        }
                        //--------------------------------------------------------------------------------------------
                        //--------------------------------------------------------------------------------------------
                        //--- end define source code and algorithm survey results arrays
                        
                        // create folder if not exist
                        bool isExists = System.IO.Directory.Exists(target_path + "\\Abstract\\" + project_name + "\\Code");
                        if (!isExists)
                            System.IO.Directory.CreateDirectory(target_path + "\\Abstract\\" + project_name + "\\Code");

                        StreamWriter sr = new StreamWriter(resultPath, false, System.Text.Encoding.UTF8);
                        //Write the heade
                        sr.WriteLine("<?xml version=\"1.0\" encoding=\"utf-8\" ?>");
                        //Write our root node
                        sr.WriteLine("<page>");
                       
                        //------------- read .cs file ----------------------------------------------
                        lines_of_code = lines.Length;            
            for (int x = 0; x < lines.Length; x++)
                        {
                            converted = 0;
                            bool flag = false;
                            //--- reset tagname

                            //--- detect empty line
                            if (lines[x].Trim().CompareTo("") == 0)
                            {
                                sr.WriteLine(lines[x].ToString());
                                x = x + 1;
                            }
                            //--- detect start of block
                            if (lines[x].Trim().StartsWith("{") == true)
                            {
                                myStack.Push(tagname);
                                sr.WriteLine("<block_start    block=\"" + tagname + "\"/>");
                                tagname = "";
                                flag = true;
                                converted = converted + 1;
                            }
                            //--- detect end of block
                            if (lines[x].Trim().EndsWith("}") == true)
                            {
                                try
                                {
                                    flag = true;
                                    converted = converted + 1;
                                    string page_class_end = myStack.Pop().ToString();
                                    if (page_class_end.Equals("pageclass") == true)
                                    {
                                        //---------- get the IDs of the other methods ---------------------------------
                                        string methods = "1,";
                                        for (int s = 0; s < lines.Length; s++)
                                        {
                                            if (other_method_id[s] > 0)
                                            {
                                                methods = methods + "" + other_method_id[s] + ",";
                                            }
                                        }
                                        //---------------- add other methods here --------------------------------------------------------
                                        OleDbCommand command43 = new OleDbCommand("SELECT different_method.ID, different_method.method_name, different_method.method_begin, different_method.method_end FROM different_method where id in ("+methods+");", connection);
                                        OleDbDataReader reader43 = command43.ExecuteReader();
                                        while (reader43.Read() && reader43.HasRows)
                                        {
                                            string android = "";
                                            int method_id = reader43.GetInt32(0);
                                            if (reader43.IsDBNull(1) == false)
                                            {
                                                sr.WriteLine("<comment type=\"singleline\" source=\"this method is added by ICPMD\">");
                                                sr.WriteLine(update_string(reader43.GetString(1)));
                                                sr.WriteLine("</comment>");
                                                sr.WriteLine("<pattern category=\"composite\"   name=\"new added method\"  type=\"suggested\"   source=\"ICPMD\">");
                                                android = "<android>" + update_string(reader43.GetString(1)) + "</android>";
                                                sr.WriteLine(android);
                                                sr.WriteLine("</pattern>");     
                                            }
                                            sr.WriteLine("{");

                                            if (reader43.IsDBNull(2) == false)
                                            {
                                                string temp43 = reader43.GetString(2);
                                                if( temp43.Contains("R.menu.main") )
                                                {
                                                    temp43 = temp43.Replace("R.menu.main", "R.menu." + file_name.ToLower());
                                                }
                                                sr.WriteLine("<comment type=\"singleline\" source=\"begin of method added by ICPMD\">");
                                                sr.WriteLine(update_string(temp43));
                                                sr.WriteLine("</comment>");
                                                sr.WriteLine("<pattern category=\"composite\"   name=\"new added method\"  type=\"suggested\"   source=\"ICPMD\">");
                                                android = "<android>" + update_string(temp43) + "</android>";
                                                sr.WriteLine(android);
                                                sr.WriteLine("</pattern>");
                                            }
                                            for (int s = 0; s < lines.Length; s++)
                                            {
                                                if (other_method_id[s] == method_id)
                                                {
                                                    sr.WriteLine("<comment type=\"singleline\" source=\"this statement is moved to this method\">");
                                                    sr.WriteLine(update_string(lines[s].ToString()));
                                                    sr.WriteLine("</comment>");

                                                    sr.WriteLine("<pattern category=\"composite\"   name=\"" + lines_pattern_name[s] + "\"  type=\"suggested\"   source=\"ICPMD\">");
                                                    if (String.IsNullOrEmpty(temp_android[s]) == false)
                                                    {
                                                        android = "<android>" +update_string( temp_android[s]) + "</android>";
                                                    }
                                                    sr.WriteLine(android);
                                                    sr.WriteLine("</pattern>");
                                                }
                                            }
                                            if (reader43.IsDBNull(3) == false)
                                            {
                                                sr.WriteLine("<comment type=\"singleline\" source=\"end of method added by ICPMD\">");
                                                sr.WriteLine(update_string(reader43.GetString(3)));
                                                sr.WriteLine("</comment>");
                                                sr.WriteLine("<pattern category=\"composite\"   name=\"new added method\"  type=\"suggested\"   source=\"ICPMD\">");
                                                android = "<android>" + update_string(reader43.GetString(3)) + "</android>";
                                                sr.WriteLine(android);
                                                sr.WriteLine("</pattern>");
                                            }
                                            sr.WriteLine("}");
                                        }
                                        //---------------- end add other methods ---------------------------------------------------------
                                    }
                                        sr.WriteLine("<block_end    block=\"" + page_class_end + "\"/>");

                                }
                                catch (Exception e)
                                {
                                    sr.WriteLine("<block_end    block=\"can not detect\"/>");
                                }

                            }
                            //--- detect original multilines comment -----------
                            if (lines[x].Trim().StartsWith("/*") == true)
                            {
                                sr.WriteLine("<comment type=\"multiline\" source=\"original comment\">");
                                sr.WriteLine(update_string(lines[x].ToString()));
                                x = x + 1;
                                while (lines[x].Contains("*/") == false)
                                {
                                    sr.WriteLine(update_string(lines[x].ToString()));
                                    x = x + 1;
                                }
                                if (lines[x].Contains("*/") == true)
                                {
                                    sr.WriteLine(update_string(lines[x].ToString()));
                                    x = x + 1;
                                }
                                sr.WriteLine("</comment>");
                            }

                            //--- detect original single line comment -----------
                            if (lines[x].Trim().StartsWith("//") == true)
                            {
                                sr.WriteLine("<comment type=\"singleline\" source=\"original comment\">");
                                sr.WriteLine(update_string(lines[x].ToString()));
                                sr.WriteLine("</comment>");
                                //x = x + 1;
                                flag = true;
                                converted = converted + 1;
                            }
                            else
                            {
                                //--- check if statement match simple pattern -------------------------------------------
                                if (lines_type[x].Equals("simple"))
                                {
                                    int gg = 0;
                                    OleDbCommand command97 = new OleDbCommand("SELECT method_name, statement, android_code_start, android_code_end FROM method_to_class where  approved=true;", connection);// where id =" + strid, connection);
                                    OleDbDataReader reader97 = command97.ExecuteReader();
                                    //while (gg==0 && reader97.Read() && reader97.HasRows )
                                    //{
                                    //   Regex r1 = new Regex(reader97.GetString(0), RegexOptions.None);

                                    //    // Match the regular expression pattern against a text string.
                                    //    Match m1 = r1.Match(lines[x]);
                                    //    //string android1 = "";
                                    //    //int matchCount = 0;
                                    //    if (m1.Success)
                                    //    {
                                    //        method_to_class.Add(m1.Groups[1].ToString());
                                    //        //  int index = 1;
                                    //        //string pattern_desc1 = "";

                                    //        sr.WriteLine("<comment type=\"singleline\" source=\"simple pattern\">");
                                    //        sr.WriteLine(update_string(lines[x].ToString()));
                                    //        sr.WriteLine("</comment>");
                                    //        flag = true;
                                    //        gg = 1;
                                    //    }
                                    //}
                                    //reader97.Close();
                                    //reader97 = command97.ExecuteReader();
                                    while (gg==0 && reader97.Read() && reader97.HasRows)
                                    {
                                        Regex r2 ;
                                        string pattern_desc ="";
                                        string android;
                                        string s2 = reader97.GetString(1);
                                        for (int s = 0; s < method_to_class.Count; s++)
                                        {
                                            r2 = new Regex(s2.Replace("@PARAM1", method_to_class[s]), RegexOptions.None);
                                        
                                        // Match the regular expression pattern against a text string.
                                        Match m2 = r2.Match(lines[x]);
                                        //string android1 = "";
                                        //int matchCount = 0;
                                        if (m2.Success)
                                        {
                                            
                                            if (!reader97.IsDBNull(2))
                                            {
                                                pattern_desc = reader97.GetString(2);
                                            }
                                            sr.WriteLine("<pattern category=\"simple\"   name=\"method mapping\"  type=\"suggested\"   source=\"ICPMD\">");
                                            android = "<android>" + update_string(pattern_desc) + "</android>";
                                            tagname = "mapped method";//pattern_desc;
                                            sr.WriteLine(android);
                                            sr.WriteLine("</pattern>");
                                            flag = true;
                                            converted = converted + 1;
                                            gg = 1;

                                        }
                                        }
                                    }
                                           
                                    OleDbCommand command9 = new OleDbCommand("SELECT statement, android_code,tagname FROM simple_patterns where id=" + lines_pattern_id[x] + " and approved=true;", connection);// where id =" + strid, connection);
                                    OleDbDataReader reader9 = command9.ExecuteReader();
                                    while (gg==0 && reader9.Read() && reader9.HasRows)   
                                    {
                                        sr.WriteLine("<comment type=\"singleline\" source=\"simple pattern\">");
                                        sr.WriteLine(update_string(lines[x].ToString()));
                                        sr.WriteLine("</comment>");



                                        Regex r = new Regex(reader9.GetString(0), RegexOptions.None);

                                        // Match the regular expression pattern against a text string.
                                        Match m = r.Match(lines[x]);
                                        string android = "";
                                        //int matchCount = 0;
                                        if (m.Success)
                                        {

                                          //  int index = 1;
                                            string pattern_desc = "";

                                            if (!reader9.IsDBNull(2))
                                            { 
                                            pattern_desc = reader9.GetString(2);
                                            }
                                            sr.WriteLine("<pattern category=\"simple\"   name=\"" + pattern_desc + "\"  type=\"suggested\"   source=\"ICPMD\">");
                                            android = "<android>" + update_string(temp_android[x]) + "</android>";
                                            tagname = pattern_desc;
                                        sr.WriteLine(android);
                                        sr.WriteLine("</pattern>");
                                        flag = true;
                                        converted = converted + 1;
                                        gg = 1;
                                        }
                                    }
                                                

                                    
                                }
                                //--- check if statement match composite pattern -------------------------------------------
                                if (lines_type[x].Equals("composite"))
                                {
                                    OleDbCommand command4 = new OleDbCommand("SELECT composite_pattern_statements.statement, composite_pattern_statements.android_output, composite_patterns.pattern,composite_pattern_statements.id FROM composite_pattern_statements INNER JOIN composite_patterns ON composite_pattern_statements.pattern_id = composite_patterns.ID  where composite_pattern_statements.pattern_id=" + lines_pattern_id[x] + ";", connection);
                                    bool flag1 = false;
                                    OleDbDataReader reader4 = command4.ExecuteReader();
                                    while (reader4.Read() && reader4.HasRows && flag1==false)
                                    {
                                        Regex r = new Regex(temp_regex[x], RegexOptions.None);
                                        int statement_id = reader4.GetInt32(3);
                                        // Match the regular expression pattern against a text string.
                                        Match m = r.Match(lines[x]);
                                        string android = "";
                                        //int matchCount = 0;
                                        if (m.Success)
                                        {
                                            flag1 = true;
                                            //converted = converted + 1;
                                          //--------- check if statement should appear in another method ---------------------
                                            if (other_method_id[x] > 0)
                                            {                                               
                                                sr.WriteLine("<comment type=\"singleline\" source=\"this statement is moved to another method\">");
                                                sr.WriteLine(update_string(lines[x].ToString()));
                                                sr.WriteLine("</comment>");                                            
                                                flag = true;
                                                converted = converted + 1;
                                            }
                                            else
                                            {
                                                sr.WriteLine("<comment type=\"singleline\" source=\"Composite pattern step " + lines_pattern_step[x] + " out of total steps " + lines_pattern_total[x] + "\">");
                                                //sr.WriteLine("Match pattern " + lines_pattern_id[x] + " step " + lines_pattern_step[x] + " - " + update_string(lines[x].ToString()));
                                                sr.WriteLine(update_string(lines[x].ToString()));
                                                sr.WriteLine("</comment>");

                                                sr.WriteLine("<pattern category=\"composite\"   name=\"" + reader4.GetString(2) + "\"  type=\"suggested\"   source=\"ICPMD\">");
                                                //sr.WriteLine("<android>"+ reader9.GetString(1)+"</android>");

                                                if (String.IsNullOrEmpty(temp_android[x]) == false)//(!reader4.IsDBNull(1))
                                                {
                                                    // android = "<android>" + reader4.GetString(1) + "</android>";
                                                    android = "<android>" + update_string(temp_android[x]) + "</android>";
                                                }
                                                tagname = reader4.GetString(2);
                                                sr.WriteLine(android);
                                                sr.WriteLine("</pattern>");
                                                flag = true;
                                                converted = converted + 1;
                                            }
                                        }
                                    }
                                }
                                else
                                {
                                    //--- search for statements patterns in the database ---------------------------------------
                                    OleDbCommand command = new OleDbCommand("SELECT wp8_regex,action_id,item,id,component_name,component_method FROM repository where approved=true", connection);// where id =" + strid, connection);
                                    //OleDbCommand command = new OleDbCommand("SELECT wp_regex,action_id,item,id,component_name,component_method FROM repository", connection);// where id =" + strid, connection);
                                    OleDbDataReader reader = command.ExecuteReader();
                                    while (reader.Read() && reader.HasRows)
                                    {
                                        var item_regex = reader.GetString(0);
                                        var strid = reader.GetInt32(3);
                                        // Instantiate the regular expression object.
                                        Regex r = new Regex(item_regex, RegexOptions.None);

                                        // Match the regular expression pattern against a text string.
                                        Match m = r.Match(lines[x]);
                                        //int matchCount = 0;
                                        while (m.Success)
                                        {
                                            flag = true;
                                            converted = converted + 1;
                                            //--- if action = comment 
                                            if (reader.GetInt32(1) == 1)
                                            {
                                                sr.WriteLine("<comment type=\"singleline\" source=\"ICPMD\">");
                                                sr.WriteLine(update_string(lines[x].ToString()));
                                                sr.WriteLine("</comment>");
                                                //x = x + 1;

                                            }
                                            //--- if action = block
                                            if (reader.GetInt32(1) == 2)
                                            {
                                                tagname = reader.GetString(2);
                                                sr.WriteLine("<comment type=\"singleline\" source=\"original\">");
                                                sr.WriteLine(update_string(lines[x].ToString()));
                                                sr.WriteLine("</comment>");
                                                if (tagname == "component")
                                                {
                                                    sr.WriteLine("<" + tagname + "   name=\"" + reader.GetString(4) + "\"   method=\"" + reader.GetString(5) + "\"   type=\"suggested\"   source=\"ICPMD\">");
                                                }
                                                else
                                                {
                                                    if (tagname == "method" && m.Groups.Count == 4 && pageclass == m.Groups[3].ToString())
                                                    {
                                                        tagname = "constructor";
                                                        sr.WriteLine("<" + tagname + "   type=\"suggested\"   source=\"ICPMD\">");
                                                    }
                                                    else
                                                    {
                                                        sr.WriteLine("<" + tagname + "   type=\"suggested\"   source=\"ICPMD\">");
                                                    }
                                                }
                                                //--- find parameters
                                                int i = 1;
                                                command = new OleDbCommand("SELECT parameter FROM parameter where item_id =" + strid, connection);
                                                OleDbDataReader reader1 = command.ExecuteReader();
                                                while (reader1.Read())
                                                {
                                                    sr.WriteLine("<param name=\"" + reader1.GetString(0) + "\"   value=\"" + m.Groups[i] + "\" />");

                                                    if (reader1.GetString(0) == "name" && tagname == "pageclass")
                                                    {
                                                        pageclass = m.Groups[i].ToString();
                                                    }
                                                    i = i + 1;
                                                }
                                                //sr.WriteLine(lines[x].ToString());
                                                sr.WriteLine("</" + tagname + ">");
                                            }

                                            m = m.NextMatch();
                                        }
                                    }
                                    reader.Close();
                                    //}
                                    // }
                                    //Close the root node
                                }
                            }
                            if (flag == false)
                            {
                                sr.WriteLine("<comment type=\"singleline\" source=\"suggested comment" + " " + tagname + "\">");
                                sr.WriteLine(update_string(lines[x].ToString()));
                                sr.WriteLine("</comment>");
                            }
                            //   dr.Close();                                                              
                        }
                        sr.WriteLine("</page>");
                        connection.Close();
                        sr.Close();

                        unconverted = lines_of_code - converted;
                    
        }

        public static void code_parser_old(string path, string project_name)
        {//string source_file_name,
            string[] lines;
            Stack myStack = new Stack();
            var tagname = "";
            string target_path = path;
            string pageclass = "";
            string source_path = path + "\\Source\\" + project_name;

            foreach (string f in Directory.GetFiles(source_path))
                if (f.EndsWith(".xaml.cs"))
                {
                    if (f.EndsWith("App.xaml.cs"))
                    {

                    }
                    else
                    {
                        string file_name = f.Substring(f.LastIndexOf("\\"));
                        string filePath = source_path + "\\" + file_name;
                        file_name = file_name.Substring(1, file_name.IndexOf(".") - 1);
                        string resultPath = target_path + "\\Abstract\\" + project_name + "\\Code\\" + file_name + ".xml";
                        lines = File.ReadAllLines(filePath);
                        // create folder if not exist
                        bool isExists = System.IO.Directory.Exists(target_path + "\\Abstract\\" + project_name + "\\Code");
                        if (!isExists)
                            System.IO.Directory.CreateDirectory(target_path + "\\Abstract\\" + project_name + "\\Code");

                        StreamWriter sr = new StreamWriter(resultPath, false, System.Text.Encoding.UTF8);
                        //Write the heade
                        sr.WriteLine("<?xml version=\"1.0\" encoding=\"utf-8\" ?>");
                        //Write our root node
                        sr.WriteLine("<page>");
                        OleDbConnection connection = new OleDbConnection("Provider = Microsoft.Jet.OLEDB.4.0; Data Source = |DataDirectory|\\icpmd.mdb");
                        connection.Open();
                        //------------- read .cs file ----------------------------------------------
                        for (int x = 0; x < lines.Length; x++)
                        {
                            bool flag = false;
                            //--- reset tagname
                            
                            //--- detect empty line
                            if (lines[x].Trim().CompareTo("") == 0)
                            {
                                sr.WriteLine(lines[x].ToString());
                                x = x + 1;
                            }
                            //--- detect start of block
                            if (lines[x].Trim().StartsWith("{") == true)
                            {
                                myStack.Push(tagname);
                                sr.WriteLine("<block_start    block=\"" + tagname + "\"/>");
                                tagname = "";
                                flag = true;
                                //converted = converted + 1;
                            }
                            //--- detect end of block
                            if (lines[x].Trim().EndsWith("}") == true)
                            {
                                //myStack.Pop(tagname);
                                try
                                {
                                    flag = true;
                                  //  converted = converted + 1;
                                    sr.WriteLine("<block_end    block=\"" + myStack.Pop() + "\"/>");
                                }
                                catch (Exception e)
                                {
                                    sr.WriteLine("<block_end    block=\"can not detect\"/>");
                                }
                                
                            }
                            //--- detect original multilines comment -----------
                            if (lines[x].Trim().StartsWith("/*") == true)
                            {
                                sr.WriteLine("<comment type=\"multiline\" source=\"original comment\">");
                                sr.WriteLine(update_string(lines[x].ToString()));
                                x = x + 1;
                                while (lines[x].Contains("*/") == false)
                                {
                                    sr.WriteLine(update_string(lines[x].ToString()));
                                    x = x + 1;
                                }
                                if (lines[x].Contains("*/") == true)
                                {
                                    sr.WriteLine(update_string(lines[x].ToString()));
                                    x = x + 1;
                                }
                                sr.WriteLine("</comment>");
                            }

                            //--- detect original single line comment -----------
                            if (lines[x].Trim().StartsWith("//") == true)
                            {
                                sr.WriteLine("<comment type=\"singleline\" source=\"original comment\">");
                                sr.WriteLine(update_string(lines[x].ToString()));
                                sr.WriteLine("</comment>");
                                //x = x + 1;
                                flag = true;
                               // converted = converted + 1;
                            }
                            else
                            {
                            //--- search for statements patterns in the database ---------------------------------------
                            OleDbCommand command = new OleDbCommand("SELECT wp8_regex,action_id,item,id,component_name,component_method FROM repository", connection);// where id =" + strid, connection);
                            OleDbDataReader reader = command.ExecuteReader();
                            while (reader.Read() && reader.HasRows)
                            {
                                var item_regex = reader.GetString(0);
                                var strid = reader.GetInt32(3);
                                // Instantiate the regular expression object.
                                Regex r = new Regex(item_regex, RegexOptions.None);

                                // Match the regular expression pattern against a text string.
                                Match m = r.Match(lines[x]);
                                //int matchCount = 0;
                                while (m.Success)
                                {
                                    flag = true;
                                   // converted = converted + 1;
                                    //--- if action = comment 
                                    if (reader.GetInt32(1) == 1)
                                    {
                                        sr.WriteLine("<comment type=\"singleline\" source=\"ICPMD\">");
                                        sr.WriteLine(update_string(lines[x].ToString()));
                                        sr.WriteLine("</comment>");
                                        //x = x + 1;

                                    }
                                    //--- if action = block
                                    if (reader.GetInt32(1) == 2)
                                    {
                                        tagname = reader.GetString(2);
                                        sr.WriteLine("<comment type=\"singleline\" source=\"original\">");
                                        sr.WriteLine(update_string(lines[x].ToString()));
                                        sr.WriteLine("</comment>");
                                        if (tagname == "component")
                                        {
                                            sr.WriteLine("<" + tagname + "   name=\"" + reader.GetString(4) + "\"   method=\"" + reader.GetString(5) + "\"   type=\"suggested\"   source=\"ICPMD\">");
                                        }
                                        else
                                        {
                                            //&& m.Groups.Count == 4
                                            if (tagname == "method"  && pageclass == m.Groups[3].ToString())
                                            {
                                                tagname = "constructor";
                                                sr.WriteLine("<" + tagname + "   type=\"suggested\"   source=\"ICPMD\">");
                                            }
                                            else
                                            {
                                            sr.WriteLine("<" + tagname + "   type=\"suggested\"   source=\"ICPMD\">");
                                            }
                                        }
                                        //--- find parameters
                                        int i = 1;
                                        command = new OleDbCommand("SELECT parameter FROM parameter where item_id =" + strid, connection);
                                        OleDbDataReader reader1 = command.ExecuteReader();
                                        while (reader1.Read())
                                        {
                                            sr.WriteLine("<param name=\"" + reader1.GetString(0) + "\"   value=\"" + m.Groups[i] + "\" />");
                                            
                                            if (reader1.GetString(0)=="name" && tagname=="pageclass")
                                            {
                                             pageclass =  m.Groups[i].ToString();
                                            }
                                            i = i + 1;
                                        }
                                        //sr.WriteLine(lines[x].ToString());
                                        sr.WriteLine("</" + tagname + ">");
                                    }

                                    m = m.NextMatch();
                                }
                            }
                            reader.Close();
                            //}
                            // }
                            //Close the root node
                             }
                            if (flag == false)
                            {     
                                sr.WriteLine("<comment type=\"singleline\" source=\"suggested comment"+" "+tagname +"\">");
                                sr.WriteLine(update_string(lines[x].ToString()));
                                sr.WriteLine("</comment>");
                            }
                            //   dr.Close();                                                              
                        }
                        sr.WriteLine("</page>");
                        connection.Close();
                        sr.Close();
                    }
                }
        }

        public static string code_converter(string source_file_name, string path, string project_name)
        {
            string s;//= File.ReadAllText(source_file_name);
            string[] lines = File.ReadAllLines(source_file_name);
            for (int x = 0; x < lines.Length; x++)
            {
                
                if (lines[x].Trim() == "namespace PhoneApp3.ICPMD")
                {
                    lines[x] = "namespace " + project_name + ".ICPMD";
                }
            }
            //File.WriteAllLines(comPath, lines);
            s = lines.ToString();            
            return s;
        }

        public static void code_analyzer2(string ast_file_name, string path, string project_name)
        {
            string target_path = path;
            string source_path = path + "\\Source\\" + project_name;
            //------------ initialize page ---------------------------------
            XElement root = XElement.Load(target_path + "\\Abstract\\" + project_name + "\\Code_Temp\\" + ast_file_name);
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
            //   $s: $V.Navigate(new Uri($V1,@));

            string pattern, step, method;
            string[] statement;
            method = "";
            pattern = "$s: $V.Navigate(new Uri($V1,@));";
            statement = pattern.Split(':');
            step = statement[0].Substring(2);
            statement[1] = statement[1].Trim();
            if (statement[1].StartsWith("$V."))
            {
                method = statement[1].Substring(3, statement[1].IndexOf('(') - 3);
            }
            
            items = from el in root.Descendants("Statement_ExpressionStatement")
                    from i in el.Elements("Expression_InvocationExpression")
                    from n in i.Elements("Target_MemberReferenceExpression")
                    where n.Attribute("MemberName").Value == method //"Navigate"
                    select el;
            
            try
            {
                foreach (XElement prdName in items)
                {
                   // MessageBox.Show(prdName.ToString());
                    //-- param mywebview
                    IEnumerable<XElement> item1 = from el11 in prdName.Descendants("Target_MemberReferenceExpression")
                                                  from i11 in el11.Elements("Target_IdentifierExpression")
                                                 select i11;
                    
                    //-- param url
                    IEnumerable<XElement> item = from el1 in prdName.Descendants("Argument_ObjectCreateExpression")
                                                 from i1 in el1.Elements("Argument_IdentifierExpression")
                                                 select i1;
               //    prdName.ReplaceNodes(new XElement("ICPMD_Webview", new XAttribute("call", "load"), new XElement("url", item.Single().Attribute("Identifier").Value)));
                    prdName.ReplaceNodes(new XElement("ICPMD_Webview_load", new XElement("mywebview", item1.Single().Attribute("Identifier").Value), new XElement("url", item.Single().Attribute("Identifier").Value)));              
                }
            }
            catch (Exception ex)
            {
               // MessageBox.Show("Processor Usage" + ex.Message);
            }
            //------------ open camera app ---------------------------------
            XElement root3 = XElement.Load(target_path + "\\Abstract\\" + project_name + "\\Code_Temp\\" + ast_file_name);
            string cameratask ="";
            string cameraevent = "";
            string cameraimage = "";
            IEnumerable<XElement> items3 = from el in root.Descendants("Body_BlockStatement")
                                           from i in el.Elements("Statement_VariableDeclarationStatement")
                                           from n in i.Elements("Type_SimpleType")
                                           where n.Attribute("Identifier").Value == "CameraCaptureTask"
                                           select i;
            try
            {
                foreach (XElement prdName in items3)
                {
                    cameratask = prdName.Element("Variable_VariableInitializer").Attribute("Name").Value;
                    prdName.ReplaceNodes(new XElement("ICPMD_Camera_app_open_1"));    
                    //--------------- step 2 -------------------------------------------------------------
                                  items3 = from el in root.Descendants("Body_BlockStatement")
                                           from i in el.Elements("Statement_ExpressionStatement")
                                           from n in i.Elements("Expression_AssignmentExpression")
                                           from m in n.Elements("Right_ObjectCreateExpression")
                                           from g in m.Elements("Type_SimpleType")
                                           where g.Attribute("Identifier").Value == "CameraCaptureTask"
                                           select i;
                foreach (XElement prdName1 in items3)
                {
                     prdName1.ReplaceNodes(new XElement("ICPMD_Camera_app_open_2"));
                    //--------------- step 3 -------------------------------------------------------------
            items3 = from el in root.Descendants("Body_BlockStatement")
                     from i in el.Elements("Statement_ExpressionStatement")
                     from n in i.Elements("Expression_AssignmentExpression")
                     from m in n.Elements("Left_MemberReferenceExpression")
                     from g in m.Elements("Target_IdentifierExpression")
                     where (g.Attribute("Identifier").Value == cameratask) && (m.Attribute("MemberName").Value == "Completed") 
                     select i;           
                foreach (XElement prdName2 in items3)
                {
                    cameraevent = prdName2.Element("Expression_AssignmentExpression").Element("Right_ObjectCreateExpression").Element("Argument_IdentifierExpression").Attribute("Identifier").Value; ;
                    prdName2.ReplaceNodes(new XElement("ICPMD_Camera_app_open_3"));
                     //--------------- step 4 -------------------------------------------------------------
            items3 = from el in root.Descendants("Body_BlockStatement")
                     from i in el.Elements("Statement_ExpressionStatement")
                     from n in i.Elements("Expression_InvocationExpression")
                     from m in n.Elements("Target_MemberReferenceExpression")
                     from g in m.Elements("Target_IdentifierExpression")
                     where (g.Attribute("Identifier").Value == cameratask) && (m.Attribute("MemberName").Value == "Show")
                     select i;
                foreach (XElement prdName3 in items3)
                {
                    prdName3.ReplaceNodes(new XElement("ICPMD_Camera_app_open"));
                         //--------------- step 5 -------------------------------------------------------------
                    items3 = from el in root.Descendants("Member_TypeDeclaration")
                     from i in el.Elements("TypeMember_MethodDeclaration")
                     from n in i.Elements("Body_BlockStatement")
                     from m in n.Descendants("Argument_MemberReferenceExpression")
                     from g in n.Descendants("Left_MemberReferenceExpression")
                     where (g.Attribute("MemberName").Value == "Source") && (m.Attribute("MemberName").Value == "ChosenPhoto") && (i.Attribute("EntityType").Value == "Method") && (i.Attribute("Name").Value == cameraevent)
                     select g;
            foreach (XElement prdName4 in items3)
            {
                cameraimage = prdName4.Element("Target_IdentifierExpression").Attribute("Identifier").Value;
            }
            items3 = from el in root.Descendants("Member_TypeDeclaration")
                     from i in el.Elements("TypeMember_MethodDeclaration")
                     from n in i.Elements("Body_BlockStatement")
                     from m in n.Descendants("Argument_MemberReferenceExpression")
                     from g in n.Descendants("Left_MemberReferenceExpression")
                     where (g.Attribute("MemberName").Value == "Source") && (m.Attribute("MemberName").Value == "ChosenPhoto") && (i.Attribute("EntityType").Value == "Method") && (i.Attribute("Name").Value == cameraevent)
                     select i;
            foreach (XElement prdName5 in items3)
            {

                prdName5.ReplaceWith(new XElement("ICPMD_Camera_app_result", new XElement("myimage", cameraimage)));
            }


                }
                }
                }
                //----------------------------------------------------------
                }
            }
            catch (Exception ex)
            {
              //  MessageBox.Show("Processor Usage" + ex.Message);
            }
          //----------------------------------------------------------
            // create folder if not exist
            bool isExists = System.IO.Directory.Exists(target_path + "\\Abstract\\" + project_name + "\\Code");
            if (!isExists)
                System.IO.Directory.CreateDirectory(target_path + "\\Abstract\\" + project_name + "\\Code");
            root.Save(target_path + "\\Abstract\\" + project_name + "\\Code\\" + ast_file_name);
            //root.Save( ast_file_name);
        }
    }
}
