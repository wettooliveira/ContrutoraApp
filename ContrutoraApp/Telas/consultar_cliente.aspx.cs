using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;

using System.Web.UI;
using System.Web.UI.WebControls;
using ContrutoraApp;


public partial class consultar_cliente : System.Web.UI.Page
{
    String user = "";
    protected void Page_Load(object sender, EventArgs e)
    {

        
        
        if (user == null)
        {
            Response.Redirect("Login.aspx");
        }
        else
        {

        }

        if (!IsPostBack)
        {

            
        }
        else
        {
            
        }


    }

    public void alertCss(string mensagem)
    {

        //HttpContext.Current.Response.Write(@"<script language=""javascript"">alertCss('" + mensagem + "');</script>");
        //ScriptManager.RegisterClientScriptBlock(this, GetType(),"alertMessage", @"alertCss(mensagem)", true);
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "alertMessage", "alertCss('" + mensagem + "');", true);
    }      

    protected void btnFiltrar_Click(object sender, EventArgs e)
    {

        List<Cliente> listCliente = new List<Cliente>();
        String sql;


        //chama o metodo de conexao com o banco
        SqlConnection cn = new SqlConnection();
        cn.ConnectionString = Conexao.StrConexao;

        //construtor command para obter dados
        SqlCommand cmd = new SqlCommand();

        try
        {

            //comando de instrução do banco de dados
            sql = "select id, razaoSocial, CNPJ from tb_cliente where fl_ativo = 'A'";


            cmd.CommandText = sql;
            //abre a conexao
            cn.Open();
            cmd.Connection = cn;
            SqlDataReader dr = cmd.ExecuteReader();


            while (dr.Read())
            {
                Cliente usu = new Cliente();
                usu.id = Convert.ToInt32(dr["id"]);
                usu.RazaoSocial = dr["razaoSocial"].ToString().ToUpper();
                usu.CNPJ = dr["CNPJ"].ToString();
                listCliente.Add(usu);
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



        gdvCliente.DataSource = listCliente;
        gdvCliente.DataBind();

    }

    protected void gdvCliente_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gdvCliente.PageIndex = e.NewPageIndex;

        btnFiltrar_Click(null, null);
    }




}
