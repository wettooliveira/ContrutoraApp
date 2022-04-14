using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;

using System.Web.UI;
using System.Web.UI.WebControls;
using ContrutoraApp;


public partial class consultar_obra : System.Web.UI.Page
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

        List<Obra> listCliente = new List<Obra>();
        String sql;


        //chama o metodo de conexao com o banco
        SqlConnection cn = new SqlConnection();
        cn.ConnectionString = Conexao.StrConexao;

        //construtor command para obter dados
        SqlCommand cmd = new SqlCommand();

        try
        {

            //comando de instrução do banco de dados
            sql = "select id_obra, desc_obra, obra.logradouro + '-' + obra.cidade as logradouro, obra.cidade, c.razaoSocial from obra obra" +
                  " inner join tb_CLIENTE c on c.id = obra.id_cliente";


            cmd.CommandText = sql;
            //abre a conexao
            cn.Open();
            cmd.Connection = cn;
            SqlDataReader dr = cmd.ExecuteReader();


            while (dr.Read())
            {
                Obra o = new Obra();
                o.id = Convert.ToInt32(dr["id_obra"]);
                o.nome = dr["desc_obra"].ToString().ToUpper();                
                o.endereco = new Endereco { logradouro = dr["logradouro"].ToString()};
                o.cliente = new Cliente { RazaoSocial = dr["razaoSocial"].ToString() };
             
                listCliente.Add(o);
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



        gdvObra.DataSource = listCliente;
        gdvObra.DataBind();

    }

    protected void gdvCliente_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gdvObra.PageIndex = e.NewPageIndex;

        btnFiltrar_Click(null, null);
    }




}
