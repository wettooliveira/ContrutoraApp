using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using ContrutoraApp;

public partial class cad_despesa : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static String Gravar(String  despesa)
        {
            string retorno = "";
            //// Passa o caminho do banco de dados para um string      
            string connectionString = Conexao.StrConexao;

            //chama o metodo de conexao com o banco
            SqlConnection cn = new SqlConnection();
            cn.ConnectionString = connectionString;

            //construtor command para obter dados44
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = cn;
            cmd.CommandText = cmd.CommandText;

            //abre a conexao
            cn.Open();

            try
            {
                 
                cmd.CommandText = "insert into tb_despesa(desc_despesa) values('"+despesa.ToUpper() +"')";
                               
                cmd.ExecuteNonQuery();

                cn.Close();

                retorno = "OK";

            }
            catch (Exception ex)
            {
                retorno = "NOK";
                //    throw new Exception("Ocorreu um erro no servdor:" + ex.Message);
            }
            finally
            {
                cn.Close();
            }

            return retorno;
        }
    }
