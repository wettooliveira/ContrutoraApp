using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ContrutoraApp;


namespace ContrutoraApp    
{
    public partial class Login : System.Web.UI.Page
    {
        string login;
        string senha;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                
            }
            else
            {
                
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {

           //Usuario usuario = new Usuario();

           // usuario.usuario = txtUsuario.Text;
           // usuario.senha = password.Value;

           // string sql;

           // // Passa o caminho do banco de dados para um string      
           // string connectionString = Conexao.StrConexao;

           // //chama o metodo de conexao com o banco
           // SqlConnection cn = new SqlConnection();
           // cn.ConnectionString = connectionString;

           // //construtor command para obter dados
           // SqlCommand cmd = new SqlCommand();

           // //comando de instrução do banco de dados
           // sql = "select * from tb_usuarios where nm_login = '" + usuario.usuario + "' And ds_senha = '" + usuario.senha + "'";

           // cmd.Connection = cn;
           // cmd.CommandText = sql;

           // //abre a conexao
           // cn.Open();
           // SqlDataReader dr = cmd.ExecuteReader();

           // while (dr.Read())
           // {
           //     login = dr["nm_login"].ToString();
           //     senha = dr["ds_senha"].ToString();

           // }

           // cn.Close();



           // if (login == usuario.usuario && senha == usuario.senha)
           // {

           //     Session["usuario"] = usuario;
                Response.Redirect("Home.aspx");

           // }
           // else
           // {


           //     lblAviso.Visible = true;

           // }
        }
    }
}