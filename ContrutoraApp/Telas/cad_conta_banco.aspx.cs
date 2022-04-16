using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using ContrutoraApp;

public partial class cad_conta_banco : System.Web.UI.Page
{
    String user = "";
    protected void Page_Load(object sender, EventArgs e)
    {

        user = (String)Session["usuario"];
        hdnUsuario.Value = user;


        if (!IsPostBack)
        {
            CarregaBancos();
        }
        else
        {

        }
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
    public static String Gravar(ContaBanco conta)
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

            if (conta.tipo == "Gravar")
            {
                cmd.CommandText = @"INSERT INTO tb_conta
                                           (cod_banco
                                           ,ds_agencia
                                           ,ds_conta)
                                     VALUES
                                           ( @cod_banco
                                           , @ds_agencia, @ds_conta)";
           
                retorno = "gravou";
            }
            else if (conta.tipo == "Alterar")
            {
                cmd.CommandText = @"update obra set
           desc_obra         = @desc_obra
           ,id_cliente        = @id_cliente
           ,cep               = @cep
           ,logradouro        = @logradouro
           ,numero            = @numero
           ,complemento       = @complemento
           ,bairro            = @bairro
           ,cidade            = @cidade
           ,uf                = @uf
           ,responsavel       = @responsavel
           ,dt_inicio_obra    = @dt_inicio_obra
           ,dt_fim_obra       = @dt_fim_obra
           ,valor             = @valor
           ,nm_alterou      = @nm_alterou
           ,dt_alterou      = @dt_alterou where id_obra = @id_obra";
                

                retorno = "alterou";
            }

            cmd.Parameters.AddWithValue("@cod_banco", conta.cod_banco);
            cmd.Parameters.AddWithValue("@ds_agencia", conta.ds_agencia);
            cmd.Parameters.AddWithValue("@ds_conta", conta.ds_conta);

            cmd.ExecuteNonQuery();

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


    [WebMethod]
    public static Obra CarregarObra(String id)
    {
        Obra getObra = new Obra();
        Dao consultarObra = new Dao();
        getObra = consultarObra.ConsultarObra(id);
        return getObra;
    }

    public void CarregaBancos()
    {
        //// Passa o caminho do banco de dados para um string      
        string connectionString = Conexao.StrConexao;

        //chama o metodo de conexao com o banco
        SqlConnection cn = new SqlConnection();
        cn.ConnectionString = connectionString;

        //construtor command para obter dados44
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = cn;

        //abre a conexao
        cn.Open();

        cmd.CommandText = @"select id, Convert(varchar(3),cod_banco) +' - '+ ds_banco as bancos from tb_bancos order by cod_banco";

        SqlDataReader dr = cmd.ExecuteReader();

        List<Despesa> lista = new List<Despesa>();
        while (dr.Read())
        {
            Despesa desp = new Despesa();
            desp.id_despesa = Convert.ToInt32(dr["id"]);
            desp.desc_despesa = dr["bancos"].ToString();
            lista.Add(desp);
        }

        dr.Close();
        cn.Close();

        ddlBanco.DataSource = lista;
        ddlBanco.DataTextField = "desc_despesa";
        ddlBanco.DataValueField = "id_despesa";
        ddlBanco.DataBind();
        ddlBanco.Items.Add(new ListItem("Selecione...", "0"));
        ddlBanco.SelectedValue = "0";


    }
}
