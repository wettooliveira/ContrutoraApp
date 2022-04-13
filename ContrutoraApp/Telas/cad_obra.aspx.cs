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
    public static Endereco BuscarCEP(String cep)
    {
        BuscaAPI buscarcep = new BuscaAPI();
        Endereco end = new Endereco();
        end = buscarcep.BuscaCEP(cep);

        return end;

    }

    [WebMethod]
    public static String Gravar(Obra obra)
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

            cmd.CommandText = @"INSERT INTO obra
           (desc_obra
           ,id_cliente
           ,cep
           ,logradouro
           ,numero
           ,complemento
           ,bairro
           ,cidade
           ,uf
           ,responsavel
           ,dt_inicio_obra
           ,dt_fim_obra
           ,nm_cadastrou
           ,dt_cadastrou)
     VALUES
           ( @desc_obra
           , @id_cliente
           , @cep
           , @logradouro
           , @numero
           , @complemento
           , @bairro
           , @cidade
           , @uf
           , @responsavel
           , @dt_inicio_obra
           , @dt_fim_obra
           , @nm_cadastrou
           , @dt_cadastrou)";

            cmd.Parameters.AddWithValue("@desc_obra", obra.nome);
            cmd.Parameters.AddWithValue("@id_cliente", obra.cliente.id);
            cmd.Parameters.AddWithValue("@cep", obra.endereco.cep);
            cmd.Parameters.AddWithValue("@logradouro", obra.endereco.logradouro);
            cmd.Parameters.AddWithValue("@numero", obra.endereco.numero);
            cmd.Parameters.AddWithValue("@complemento", obra.endereco.complemento);
            cmd.Parameters.AddWithValue("@bairro", obra.endereco.bairro);
            cmd.Parameters.AddWithValue("@cidade", obra.endereco.cidade);
            cmd.Parameters.AddWithValue("@uf", obra.endereco.uf);
            cmd.Parameters.AddWithValue("@responsavel", obra.responsavel);
            cmd.Parameters.AddWithValue("@dt_inicio_obra", DateTime.Now);
            cmd.Parameters.AddWithValue("@dt_fim_obra", DateTime.Now);
            cmd.Parameters.AddWithValue("@nm_cadastrou", obra.cliente.nm_cadastrou);
            cmd.Parameters.AddWithValue("@dt_cadastrou", DateTime.Now);

            cmd.ExecuteNonQuery();      

            retorno = "OK";

        }
        catch (Exception ex)
        {
            cn.Close();
            retorno = "NOK";
             throw new Exception("Ocorreu um erro no servdor:" + ex.Message);
        }
        finally
        {
            cn.Close();
        }

        return retorno;
    }
}
