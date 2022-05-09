using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;

using System.Web.UI;
using System.Web.UI.WebControls;
using ContrutoraApp;

public partial class cad_cliente : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        hdnUsuario.Value = (String)Session["usuario"];
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
    public static String Gravar(Cliente cliente)
    {
        Dao inserirdados = new Dao();

        return inserirdados.GravarCliente(cliente);

    }

    [WebMethod]
    public static Cliente CarregarCliente(String id)
    {
        Cliente getCliente = new Cliente();
        Dao consultarCliente = new Dao();
        getCliente = consultarCliente.ConsultarCliente(id);
        return getCliente;
    }

    [WebMethod]
    public static String AlterarCliente(Cliente cliente)
    {
        String retorno = "";  
        Dao consultarCliente = new Dao();
        return retorno;
      
    }
}
