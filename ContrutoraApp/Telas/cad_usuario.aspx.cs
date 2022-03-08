using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ContrutoraApp;


public partial class cad_usuario : System.Web.UI.Page
{
    String user = "";
    protected void Page_Load(object sender, EventArgs e)
    {

        user = (String)Session["usuario"];

        //if (user == null)
        //{
        //    Response.Redirect("Login.aspx");
        //}
        //else
        //{

        //}

        if (!IsPostBack)
        {
            txtSenha.Text = "";
            txtUsuarioSenha.Text = "";
        }
        else
        {
            if (hdnAcao.Value == "usuario")
            {
                CarregarUsuario(hdnId_usuario.Value);
                hdnAcao.Value = "";
            }
        }


    }

    public void alertCss(string mensagem)
    {
        //HttpContext.Current.Response.Write(@"<script language=""javascript"">alertCss('" + mensagem + "');</script>");
        //ScriptManager.RegisterClientScriptBlock(this, GetType(),"alertMessage", @"alertCss(mensagem)", true);
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "alertMessage", "alertCss('" + mensagem + "');", true);
    }

    protected void btnGravar_Click(object sender, EventArgs e)
    {

        Usuario usuario = new Usuario();
        usuario.ds_nome = txtNome.Text;
        usuario.usuario = txtUsuarioSenha.Text;
        usuario.senha = txtSenha.Text;
        usuario.nm_cadastrou = user;
        usuario.nm_login = hdnId_usuario.Value;

        String sql;

        // Passa o caminho do banco de dados para um string      


        //chama o metodo de conexao com o banco
        SqlConnection cn = new SqlConnection();
        cn.ConnectionString = Conexao.StrConexao;

        //construtor command para obter dados
        SqlCommand cmd = new SqlCommand();

        if (btnGravar.Text == "Gravar")
        {


            //comando de instrução do banco de dados
            cmd.CommandText = "INSERT INTO tb_usuario (ds_nome,nm_login,ds_senha,nm_cadastrou,dt_cadastrou)" +
                   "VALUES(@ds_nome, @usuario, @senha, @nm_cadastrou, @dt_cadastrou)";


            cmd.Connection = cn;    
            //abre a conexao
            cn.Open();

            cmd.Parameters.AddWithValue("@ds_nome", usuario.ds_nome);
            cmd.Parameters.AddWithValue("@usuario", usuario.usuario);
            cmd.Parameters.AddWithValue("@senha", usuario.senha);
            cmd.Parameters.AddWithValue("@nm_cadastrou", usuario.nm_cadastrou);
            cmd.Parameters.AddWithValue("@dt_cadastrou", DateTime.Now);

            cmd.ExecuteNonQuery();

            cn.Close();

            alertCss("Gravado");
        }
        else
        {

            //comando de instrução do banco de dados
            sql = "UPDATE tb_usuarios SET ds_nome = @ds_nome , nm_login = @nm_login, ds_senha = @ds_senha, nm_alterou = @nm_alterou, dt_alterou = @dt_alterou where id_usuario = @id_usuario";


            cmd.Connection = cn;
            cmd.CommandText = sql;

            //abre a conexao
            cn.Open();

            cmd.Parameters.AddWithValue("@ds_nome", usuario.ds_nome);
            cmd.Parameters.AddWithValue("@nm_login", usuario.usuario);
            cmd.Parameters.AddWithValue("@ds_senha", usuario.senha);
            cmd.Parameters.AddWithValue("@nm_alterou", usuario.nm_cadastrou);
            cmd.Parameters.AddWithValue("@dt_alterou", DateTime.Now);
            cmd.Parameters.AddWithValue("@id_usuario", usuario.nm_login);

            cmd.ExecuteNonQuery();

            cn.Close();


            alertCss("Alterado");

            btnFiltrar_Click(null, null);

            txtNome.Text = "";
            txtSenha.Text = "";
            txtUsuarioSenha.Text = "";

        }

    }

    protected void btnFiltrar_Click(object sender, EventArgs e)
    {

        List<Usuario> listusuario = new List<Usuario>();
        String sql;


        //chama o metodo de conexao com o banco
        SqlConnection cn = new SqlConnection();
        cn.ConnectionString = Conexao.StrConexao;

        //construtor command para obter dados
        SqlCommand cmd = new SqlCommand();

        try
        {

            //comando de instrução do banco de dados
            sql = "select id_usuario, ds_nome, nm_login from tb_usuarios";


            cmd.CommandText = sql;
            //abre a conexao
            cn.Open();
            cmd.Connection = cn;
            SqlDataReader dr = cmd.ExecuteReader();


            while (dr.Read())
            {
                Usuario usu = new Usuario();
                usu.id_usuario = Convert.ToInt32(dr["id_usuario"]);
                usu.ds_nome = dr["ds_nome"].ToString();
                usu.usuario = dr["nm_login"].ToString();
                listusuario.Add(usu);
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



        GridUsuario.DataSource = listusuario;
        GridUsuario.DataBind();

    }

    protected void CarregarUsuario(String id_usuario)
    {
        id_usuario = hdnId_usuario.Value;
        Usuario usuario = new Usuario();
        //Atendimento_Dal dal = new Atendimento_Dal();
        //dal.Atendimento(id_usuario);



        string sql;

      
        //chama o metodo de conexao com o banco
        SqlConnection cn = new SqlConnection();
        cn.ConnectionString = Conexao.StrConexao;

        //construtor command para obter dados44
        SqlCommand cmd = new SqlCommand();


        //comando de instrução do banco de dados
        cmd.CommandText = "select * from tb_usuarios where id_usuario =" + id_usuario;

        cmd.Connection = cn;
        //abre a conexao
        cn.Open();
        SqlDataReader dr = cmd.ExecuteReader();

        while (dr.Read())
        {

            usuario.ds_nome = dr["ds_nome"].ToString();
            usuario.usuario = dr["nm_login"].ToString();
            usuario.senha = dr["ds_senha"].ToString();

        }


        cn.Close();

        txtNome.Text = usuario.ds_nome;
        txtUsuarioSenha.Text = usuario.usuario;
        txtSenha.Text = usuario.senha;
        btnAlterarSenha.Attributes.Add("class", "btn btn-default");

        btnGravar.Text = "Alterar";


    }
}
