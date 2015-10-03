// Class Name : DH Tools
// Version : Beta
// Author : Doddy Hackman
// (C) Doddy Hackman 2014
//
// Functions :
//
// [+] HTTP Methods GET & POST
// [+] Get HTTP Status code number
// [+] HTTP FingerPrinting
// [+] Read File
// [+] Write File
// [+] GET OS
// [+] Remove duplicates from a List
// [+] Cut urls from a List
// [+] Download
// [+] Upload
// [+] Get Basename from a path
// [+] Execute commands
// [+] URI Split
// [+] MD5 Hash Generator
// [+] Get MD5 of file
// [+] Get IP address from host name
//
// Credits :
//
// Method POST -> https://technet.rapaport.com/Info/Prices/SampleCode/Full_Example.aspx
// Method GET -> http://stackoverflow.com/questions/4510212/how-i-can-get-web-pages-content-and-save-it-into-the-string-variable
// HTTP Headers -> http://msdn.microsoft.com/en-us/library/system.net.httpwebresponse.headers%28v=vs.110%29.aspx
// List Cleaner -> http://forums.asp.net/t/1318899.aspx?Remove+duplicate+items+from+List+String+
// Execute command -> http://www.codeproject.com/Articles/25983/How-to-Execute-a-Command-in-C
// MD5 Hash Generator -> http://www.java2s.com/Code/CSharp/Security/GetandverifyMD5Hash.htm
// Get MD5 of file -> http://stackoverflow.com/questions/10520048/calculate-md5-checksum-for-a-file
//
// Thanks to : $DoC and atheros14 (Forum indetectables)
//

using System;
using System.Collections.Generic;
using System.Text;

using System.Net;
using System.IO;
using System.Text.RegularExpressions;
using System.Security.Cryptography;

namespace Stub
{
    class DH_Tools
    {
        public string toma(string url)
        {
            string code = "";

            try
            {
                WebClient nave = new WebClient();
                nave.Headers["User-Agent"] = "Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:25.0) Gecko/20100101 Firefox/25.0";
                code = nave.DownloadString(url);
            }
            catch
            {
                //
            }
            return code;
        }

        public string tomar(string url, string par)
        {

            string code = "";

            try
            {

                HttpWebRequest nave = (HttpWebRequest)
                WebRequest.Create(url);

                nave.UserAgent = "Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:25.0) Gecko/20100101 Firefox/25.0";
                nave.Method = "POST";
                nave.ContentType = "application/x-www-form-urlencoded";

                Stream anteantecode = nave.GetRequestStream();

                anteantecode.Write(Encoding.ASCII.GetBytes(par), 0, Encoding.ASCII.GetBytes(par).Length);
                anteantecode.Close();

                StreamReader antecode = new StreamReader(nave.GetResponse().GetResponseStream());
                code = antecode.ReadToEnd();

            }
            catch
            {
                //
            }

            return code;

        }

        public string respondecode(string url)
        {
            String code = "";
            try
            {
                HttpWebRequest nave = (HttpWebRequest)WebRequest.Create(url);
                nave.UserAgent = "Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:25.0) Gecko/20100101 Firefox/25.0";
                HttpWebResponse num = (HttpWebResponse)nave.GetResponse();

                int number = (int)num.StatusCode;
                code = Convert.ToString(number);

            }
            catch
            {

                code = "404";

            }
            return code;
        }

        public string httpfinger(string url)
        {

            String code = "";

            try
            {

                HttpWebRequest nave1 = (HttpWebRequest)WebRequest.Create(url);
                HttpWebResponse nave2 = (HttpWebResponse)nave1.GetResponse();

                for (int num = 0; num < nave2.Headers.Count; ++num)
                {
                    code = code + "[+] " + nave2.Headers.Keys[num] + ":" + nave2.Headers[num] + Environment.NewLine;
                }

                nave2.Close();
            }
            catch
            {
                //
            }

            return code;

        }

        public string openword(string file)
        {
            String code = "";
            try
            {
                code = System.IO.File.ReadAllText(file);
            }
            catch
            {
                //
            }
            return code;
        }

        public void savefile(string file, string texto)
        {

            try
            {
                System.IO.StreamWriter save = new System.IO.StreamWriter(file, true);
                save.Write(texto);
                save.Close();
            }
            catch
            {
                //
            }
        }

        public string getos()
        {
            string code = "";

            try
            {
                System.OperatingSystem os = System.Environment.OSVersion;
                code = Convert.ToString(os);
            }
            catch
            {
                code = "?";
            }

            return code;
        }

        public List<string> repes(List<string> array)
        {
            List<string> repe = new List<string>();
            foreach (string lin in array)
            {
                if (!repe.Contains(lin))
                {
                    repe.Add(lin);
                }
            }

            return repe;

        }

        public List<string> cortar(List<string> otroarray)
        {
            List<string> cort = new List<string>();

            foreach (string row in otroarray)
            {

                String lineafinal = "";

                Match regex = Regex.Match(row, @"(.*)\?(.*)=(.*)", RegexOptions.IgnoreCase);
                if (regex.Success)
                {
                    lineafinal = regex.Groups[1].Value + "?" + regex.Groups[2].Value + "=";
                    cort.Add(lineafinal);
                }

            }

            return cort;
        }

        public string download(string url, string savename)
        {

            String code = "";

            WebClient nave = new WebClient();
            nave.Headers["User-Agent"] = "Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:25.0) Gecko/20100101 Firefox/25.0";

            try
            {
                nave.DownloadFile(url, savename);
                code = "OK";
            }
            catch
            {
                code = "Error";
            }

            return code;
        }

        public string upload(string link, string archivo)
        {

            String code = "";

            try
            {

                WebClient nave = new WebClient();
                nave.Headers["User-Agent"] = "Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:25.0) Gecko/20100101 Firefox/25.0";
                byte[] codedos = nave.UploadFile(link, "POST", archivo);
                code = System.Text.Encoding.UTF8.GetString(codedos, 0, codedos.Length);

            }

            catch
            {
                code = "Error";
            }

            return code;

        }

        public string basename(string file)
        {
            String nombre = "";

            FileInfo basename = new FileInfo(file);
            nombre = basename.Name;

            return nombre;

        }

        public string console(string cmd)
        {

            string code = "";

            try
            {

                System.Diagnostics.ProcessStartInfo loadnow = new System.Diagnostics.ProcessStartInfo("cmd", "/c " + cmd);
                loadnow.RedirectStandardOutput = true;
                loadnow.UseShellExecute = false;
                loadnow.CreateNoWindow = true;
                System.Diagnostics.Process loadnownow = new System.Diagnostics.Process();
                loadnownow.StartInfo = loadnow;
                loadnownow.Start();
                code = loadnownow.StandardOutput.ReadToEnd();

            }

            catch
            {
                code = "Error";
            }

            return code;

        }

        public string urisplit(string url, string opcion)
        {

            string code = "";

            Uri dividir = new Uri(url);

            if (opcion == "host")
            {
                code = dividir.Host;
            }

            if (opcion == "port")
            {
                code = Convert.ToString(dividir.Port);
            }

            if (opcion == "path")
            {
                code = dividir.LocalPath;
            }

            if (opcion == "file")
            {
                code = dividir.AbsolutePath;
                FileInfo basename = new FileInfo(code);
                code = basename.Name;
            }

            if (opcion == "query")
            {
                code = dividir.Query;
            }

            if (opcion == "")
            {
                code = "Error";
            }

            return code;
        }

        public string convertir_md5(string text)
        {
            MD5 convertirmd5 = MD5.Create();
            byte[] infovalor = convertirmd5.ComputeHash(Encoding.Default.GetBytes(text));
            StringBuilder guardar = new StringBuilder();
            for (int numnow = 0; numnow < infovalor.Length; numnow++)
            {
                guardar.Append(infovalor[numnow].ToString("x2"));
            }
            return guardar.ToString();
        }

        public string md5file(string file)
        {

            string code = "";

            try
            {
                var gen = MD5.Create();
                var ar = File.OpenRead(file);
                code = BitConverter.ToString(gen.ComputeHash(ar)).Replace("-", "").ToLower();

            }
            catch
            {
                code = "Error";
            }

            return code;
        }

        public string getip(string host)
        {
            string code = "";
            try
            {
                IPAddress[] find = Dns.GetHostAddresses(host);
                code = find[0].ToString();
            }
            catch
            {
                code = "Error";
            }
            return code;
        }

    }
}

// The End ?