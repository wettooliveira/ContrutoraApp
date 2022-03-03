using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ContrutoraApp;


public partial class Home : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void consultarUsuario(String nm_usuario)
    {

        string sql;

        // Passa o caminho do banco de dados para um string      
        string connectionString = Conexao.StrConexao;

        //chama o metodo de conexao com o banco
        SqlConnection cn = new SqlConnection();
        cn.ConnectionString = connectionString;

        //construtor command para obter dados
        SqlCommand cmd = new SqlCommand();

        //comando de instrução do banco de dados
        sql = "select * from tb_usuarios where nm_login ='" + nm_usuario + "'";

        cmd.Connection = cn;
        cmd.CommandText = sql;

        //abre a conexao
        cn.Open();
        SqlDataReader dr = cmd.ExecuteReader();

        Usuario login = new Usuario();

        while (dr.Read())
        {
            login.usuario = dr["nm_login"].ToString();
        }

        cn.Close();

        //divUsuario.InnerHtml = login.usuario.ToString();


    }
}
