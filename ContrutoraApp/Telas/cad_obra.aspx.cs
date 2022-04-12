using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using ContrutoraApp;

public partial class cad_obra : System.Web.UI.Page
{
    String user = "";
    protected void Page_Load(object sender, EventArgs e)
    {
       
        user = (String)Session["usuario"];
        hdnUsuario.Value = user;
    }

    [WebMethod]
    public static String Gravar(Cliente cliente)
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

            cmd.CommandText = "insert into obra(desc_obra,desc_endereco,id_cliente,dt_inicio_obra,dt_fim_obra,nm_cadastrou,dt_cadastrou) " +
                               "values(@desc_obra,@desc_endereco,@id_cliente,@dt_inicio_obra,@dt_fim_obra,@nm_cadastrou,@dt_cadastrou)";

            cmd.Parameters.AddWithValue("@desc_obra", cliente.RazaoSocial);
            cmd.Parameters.AddWithValue("@desc_endereco", cliente.endereco.logradouro);
            cmd.Parameters.AddWithValue("@id_cliente", cliente.id);
            cmd.Parameters.AddWithValue("@dt_inicio_obra", cliente.dt_cadastrou);
            cmd.Parameters.AddWithValue("@dt_fim_obra", cliente.data);
            cmd.Parameters.AddWithValue("@nm_cadastrou", cliente.nm_cadastrou);
            cmd.Parameters.AddWithValue("@dt_cadastrou", DateTime.Now);

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
