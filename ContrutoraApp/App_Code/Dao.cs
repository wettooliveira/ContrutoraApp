using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace ContrutoraApp
{
    public class Dao
    {
        public String GravarCliente(Cliente cliente)
        {

            try
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
                cmd.CommandText = @"INSERT INTO tb_cliente(razaoSocial,
                                                       CNPJ, 
                                                       IE,
                                                       tel,
                                                       cep,
                                                       logradouro,
                                                       numero,
                                                       complemento,
                                                       bairro,
                                                       cidade,
                                                       uf,
                                                       obs,
                                                       nm_cadastrou,
                                                       dt_cadastrou)
                                                values(@razaoSocial,
                                                       @CNPJ, 
                                                       @IE,
                                                       @tel,
                                                       @cep,
                                                       @logradouro,
                                                       @numero,
                                                       @complemento,
                                                       @bairro,
                                                       @cidade,
                                                       @uf,
                                                       @obs,
                                                       @nm_cadastrou,
                                                       @dt_cadastrou)";
                cmd.Parameters.AddWithValue("@razaoSocial", cliente.RazaoSocial);
                cmd.Parameters.AddWithValue("@CNPJ", cliente.CNPJ);
                cmd.Parameters.AddWithValue("@IE", cliente.IE);
                cmd.Parameters.AddWithValue("@tel", cliente.tel);
                cmd.Parameters.AddWithValue("@cep", cliente.endereco.cep);
                cmd.Parameters.AddWithValue("@logradouro", cliente.endereco.logradouro);
                cmd.Parameters.AddWithValue("@numero", cliente.endereco.numero);
                cmd.Parameters.AddWithValue("@complemento", cliente.endereco.complemento);
                cmd.Parameters.AddWithValue("@bairro", cliente.endereco.bairro);
                cmd.Parameters.AddWithValue("@cidade", cliente.endereco.cidade);
                cmd.Parameters.AddWithValue("@uf", cliente.endereco.uf);
                cmd.Parameters.AddWithValue("@obs", cliente.obs);
                cmd.Parameters.AddWithValue("@nm_cadastrou", cliente.nm_cadastrou);
                cmd.Parameters.AddWithValue("@dt_cadastrou", DateTime.Now);

                cmd.ExecuteNonQuery();
                cn.Close();

                return "OK";
            }
            catch (Exception ex)
            {
                return "ERRO";
            }


        }

        public String Menu()
        {
           String menu = @"<div class='navbar navbar-inverse navbar-fixed-top'>
             <div class='container'>
                <div class='navbar-header'>
                    <button type='button' class='navbar-toggle' data-toggle='collapse' data-target='.navbar-collapse'>
                        <span class='icon-bar'></span>
                        <span class='icon-bar'></span>
                        <span class='icon-bar'></span>
                    </button>
                    <img src ='' style='width:30px; height:50px' />
                </div>
                <div class='navbar-collapse collapse'>
                    <ul class='nav navbar-nav'>
                        <li><a href='Home.aspx' > Página inicial</a></li>

                        <li><a style='cursor: pointer' onclick='abrirUsuario()'>Usuario</a></li>
                        <li><a style='cursor: pointer' onclick='Contaspagar()'>Financeiro</a></li>
                        <li><a style='cursor: pointer' onclick='cliente()'>Cadastros</a></li>
                        <li><a href='cad_cliente.aspx' style='cursor: pointer'>Cadastros</a></li>
                        <li><a href='About' > Sobre </a></li>
                        <li><a href='Contact'>Contato</a></li>
                    </ul>
                    <ul class='nav navbar-nav navbar-right'>
                        <li><a href= 'Account/Register' > Registrar </a></li>
                        <li><a href='Login'>Logon</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <br />
        <br />
        <br />";

            return menu;

        }
    }
}