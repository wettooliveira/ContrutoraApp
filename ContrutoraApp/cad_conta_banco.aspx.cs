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
                                           (id_banco
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
                                                    id_banco         = @cod_banco
                                                   ,ds_agencia        = @ds_agencia
                                                   ,ds_conta          = @ds_conta where id_obra = @id_obra";



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

    protected void GridUsuario_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridUsuario.PageIndex = e.NewPageIndex;

        btnFiltrar_Click(null, null);
    }

    protected void btnFiltrar_Click(object sender, EventArgs e)
    {
        List<Contas> listContas = new List<Contas>();
        String sql;


        //chama o metodo de conexao com o banco
        SqlConnection cn = new SqlConnection();
        cn.ConnectionString = Conexao.StrConexao;
        
       // construtor command para obter dados
        SqlCommand cmd = new SqlCommand();

        try
        {

            //comando de instrução do banco de dados
            sql = "select c.id, c.id_banco, c.ds_agencia +' - '+ c.ds_conta as conta, Convert(varchar(3),cod_banco) +' - '+ ds_banco as bancos from tb_conta c " +
                "inner join  tb_bancos b on b.id = c.id_banco order by id_banco";


            cmd.CommandText = sql;
            //abre a conexao
            cn.Open();
            cmd.Connection = cn;
            SqlDataReader dr = cmd.ExecuteReader();


            while (dr.Read())
            {
                Contas usu = new Contas();
                usu.id = Convert.ToInt32(dr["id"]);
                usu.desc_conta = dr["conta"].ToString();
                usu.desc_despesa = dr["bancos"].ToString();
                listContas.Add(usu);
            }

        }
        catch (Exception ex)
        {
            throw new Exception("Ocorreu um erro no servdor:" + ex.Message);
        }
        finally
        {
            cn.Close();
        }



        GridUsuario.DataSource = listContas;
        GridUsuario.DataBind();
    }

    [WebMethod]
    public static String ExcluirConta(String id)
    {
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

        //comando de instrução do banco de dados
        cmd.CommandText = @"delete tb_conta where id = " + id;
        cmd.ExecuteNonQuery();  

        cn.Close();
        return "OK";

    }


}
