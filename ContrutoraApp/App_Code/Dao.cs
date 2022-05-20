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
            String retorno = "";
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

                //comando de instrução do banco de dados
                cmd.CommandText = @"INSERT INTO tb_cliente(id,
                                                       razaoSocial,
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
                                                       tp_cli_fornc,
                                                       nm_cadastrou,
                                                       dt_cadastrou)
                                                values(next value for dbo.CLIENTE,
                                                       @razaoSocial,
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
                                                       @tp_cli_fornc,
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
                cmd.Parameters.AddWithValue("@tp_cli_fornc", cliente.tp_cli_fornc);
                cmd.Parameters.AddWithValue("@nm_cadastrou", cliente.nm_cadastrou);
                cmd.Parameters.AddWithValue("@dt_cadastrou", DateTime.Now);

                cmd.ExecuteNonQuery();


                retorno = "OK,gravar";
            }
            catch (Exception ex)
            {
                retorno = "ERRO,";
            }

            cn.Close();
            return retorno;
        }
        public Cliente ConsultarCliente(String id)
        {

            List<Cliente> listaCliente = new List<Cliente>();
            Cliente cliente = new Cliente();

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


            //comando de instrução do banco de dados
            cmd.CommandText = @"select id,
                                       razaoSocial,
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
                                       tp_cli_fornc,                                      
                                       fl_ativo from tb_cliente WHERE id = @id";


            cmd.Parameters.AddWithValue("@id", id);

            SqlDataReader dr = cmd.ExecuteReader();


            while (dr.Read())
            {

                cliente.id = Convert.ToInt32(dr["id"]);
                cliente.RazaoSocial = dr["razaoSocial"].ToString();
                cliente.CNPJ = dr["CNPJ"].ToString();
                cliente.IE = dr["IE"].ToString();
                cliente.tel = dr["tel"].ToString();
                cliente.endereco = new Endereco
                {
                    logradouro = dr["logradouro"].ToString(),
                    cep = dr["cep"].ToString(),
                    numero = dr["numero"].ToString(),
                    complemento = dr["complemento"].ToString(),
                    bairro = dr["bairro"].ToString(),
                    cidade = dr["cidade"].ToString(),
                    uf = dr["uf"].ToString()
                };
                cliente.obs = dr["obs"].ToString();
                cliente.tp_cli_fornc = dr["tp_cli_fornc"].ToString();
            }


            dr.Close();
            cn.Close();

            return cliente;
        }
        public String AlterarClientes(Cliente cliente)
        {
            String retorno = "";
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

                //comando de instrução do banco de dados
                cmd.CommandText = @"update  tb_cliente set
                                                       razaoSocial  =@razaoSocial,
                                                       CNPJ         =@CNPJ, 
                                                       IE           =@IE,
                                                       tel          =@tel,
                                                       cep          =@cep,
                                                       logradouro   =@logradouro,
                                                       numero       =@numero,
                                                       complemento  =@complemento,
                                                       bairro       =@bairro,
                                                       cidade       =@cidade,
                                                       uf           =@uf,
                                                       obs          =@obs,
                                                       tp_cli_fornc  =@tp_cli_fornc   where id = @id";


                cmd.Parameters.AddWithValue("@id", cliente.id);
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
                cmd.Parameters.AddWithValue("@tp_cli_fornc", cliente.tp_cli_fornc);


                cmd.ExecuteNonQuery();


                retorno = "OK,alterar";
            }
            catch (Exception ex)
            {
                retorno = "ERRO,";
            }

            cn.Close();
            return retorno;
        }
        public Cliente ConsultarFornecedor(String id)
        {

            List<Cliente> listaCliente = new List<Cliente>();
            Cliente cliente = new Cliente();

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


            //comando de instrução do banco de dados
            cmd.CommandText = @"select id,
                                       razaoSocial,
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
                                       tp_cli_fornc,                                      
                                       fl_ativo from tb_cliente WHERE id = @id and tp_cli_fornc = 'fornecedor' and fl_ativo = 'A' ";


            cmd.Parameters.AddWithValue("@id", id);

            SqlDataReader dr = cmd.ExecuteReader();


            while (dr.Read())
            {

                cliente.id = Convert.ToInt32(dr["id"]);
                cliente.RazaoSocial = dr["razaoSocial"].ToString();
                cliente.CNPJ = dr["CNPJ"].ToString();
                cliente.IE = dr["IE"].ToString();
                cliente.tel = dr["tel"].ToString();
                cliente.endereco = new Endereco
                {
                    logradouro = dr["logradouro"].ToString(),
                    cep = dr["cep"].ToString(),
                    numero = dr["numero"].ToString(),
                    complemento = dr["complemento"].ToString(),
                    bairro = dr["bairro"].ToString(),
                    cidade = dr["cidade"].ToString(),
                    uf = dr["uf"].ToString()
                };
                cliente.obs = dr["obs"].ToString();
                cliente.tp_cli_fornc = dr["tp_cli_fornc"].ToString();
            }


            dr.Close();
            cn.Close();

            return cliente;
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
                        <li><a style='cursor: pointer' onclick='ContasPagar()'>Financeiro</a></li>
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

        //------------------------------------- CONTAS A PAGAR -----------------------------------------------//
        public String GravarDetalhesDao(Contas Contas)
        {
            String retorno = "";

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

                //comando de instrução do banco de dados
                cmd.CommandText = @"INSERT INTO tb_detalhes_contasPagar(num_conta, desc_detalhe, qtde, valor, nf)
                                    Values(@id_conta, @desc_conta, @num_parcela, @valor, @nf)";

                cmd.Parameters.AddWithValue("@desc_conta", Contas.desc_conta.ToUpper());
                cmd.Parameters.AddWithValue("@num_parcela", Contas.num_parcela);
                cmd.Parameters.AddWithValue("@valor", Contas.valor);
                cmd.Parameters.AddWithValue("@id_conta", Contas.num_conta);
                cmd.Parameters.AddWithValue("@nf", Contas.nf);

                cmd.ExecuteNonQuery();          
                retorno = "OK" + "@" + Contas.num_conta.ToString();
                cn.Close();
            }
            catch (Exception ex)
            {
                retorno = "ERRO";
            }

            return retorno;
        }

        public Contas BuscarDadosDetalhesModal(Contas contas, string tipo)
        {

            double soma = 0;
            Contas retorno = new Contas();
            List<Contas> listaDados1 = new List<Contas>();
            List<Contas> listaDados2 = new List<Contas>();



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

            if (tipo != "gravar")
            {


                //comando de instrução do banco de dados
                cmd.CommandText = @"INSERT into tb_temp_detalhes_contasPagar(id_conta, desc_detalhe, qtde, valor, nf)
								    SELECT id_conta, desc_detalhe, qtde, valor, nf from tb_detalhes_contasPagar Where id_conta = @id_obra";

                cmd.Parameters.AddWithValue("@id_obra", contas.id_obra);

                cmd.ExecuteNonQuery();
                cmd.Parameters.Clear();
            }

            //cmd.CommandText = @"SELECT id_temp_detalhes_contasPagar, desc_detalhe, qtde, valor, total FROM tb_temp_detalhes_contasPagar 
            //                    OUTER APPLY(select sum(valor*qtde) as total from tb_temp_detalhes_contasPagar)total  
            //                    WHERE id_contaPagar = @id_obra
            //                    ORDER BY 1 DESC";

            //cmd.Parameters.AddWithValue("@id_obra", contas.id_obra);

            //SqlDataReader dr = cmd.ExecuteReader();

            //if (dr.HasRows)
            //{
            //    while (dr.Read())
            //    {
            //        Contas dadosTabelaDetalhes = new Contas();
            //        dadosTabelaDetalhes.id = Convert.ToInt32(dr["id_temp_detalhes_contasPagar"]);
            //        dadosTabelaDetalhes.desc_conta = dr["desc_detalhe"].ToString();
            //        dadosTabelaDetalhes.qtde = dr["qtde"].ToString();
            //        dadosTabelaDetalhes.valor = Convert.ToDouble(dr["valor"]);
            //        dadosTabelaDetalhes.valor_string = Convert.ToDouble(dr["total"]).ToString("N2");
            //        //soma += Convert.ToDouble(dr["valor"]);
            //        //dadosTabelaDetalhes.valor_string = soma.ToString("N2");

            //        listaDados1.Add(dadosTabelaDetalhes);
            //        retorno.listaContas1 = listaDados1;
            //    }
            //}
            //else
            //{
            //    Contas c = new Contas();
            //    c.desc_conta = "vazio";
            //    listaDados1.Add(c);
            //    retorno.listaContas1 = listaDados1;
            //}

            //dr.Close();
            //cmd.Parameters.Clear();



            ////comando de instrução do banco de dados
            //cmd.CommandText = @"SELECT id, desc_detalhe, qtde, valor, total FROM tb_detalhes_contasPagar 
            //                    OUTER APPLY(select sum(valor*qtde) as total from tb_detalhes_contasPagar)total
            //                    WHERE id_conta = @id_obra
            //                    ORDER BY 1 DESC";

            //cmd.Parameters.AddWithValue("@id_obra", contas.id_obra);

            //dr = cmd.ExecuteReader();


            //if (dr.HasRows)
            //{
            //    while (dr.Read())
            //    {
            //        Contas dadosTabelaDetalhes = new Contas();
            //        dadosTabelaDetalhes.id = Convert.ToInt32(dr["id"]);
            //        dadosTabelaDetalhes.desc_conta = dr["desc_detalhe"].ToString();
            //        dadosTabelaDetalhes.tipo = dr["qtde"].ToString();
            //        dadosTabelaDetalhes.valor = Convert.ToDouble(dr["valor"]);
            //        dadosTabelaDetalhes.valor_string = Convert.ToDouble(dr["total"]).ToString("N2");
            //        soma += Convert.ToDouble(dr["valor"]);
            //        dadosTabelaDetalhes.valor_string = soma.ToString("N2");

            //        listaDados2.Add(dadosTabelaDetalhes);
            //        retorno.listaContas2 = listaDados2;
            //    }
            //}
            //else
            //{
            //    Contas c = new Contas();
            //    c.desc_conta = "vazio";
            //    listaDados2.Add(c);
            //    retorno.listaContas2 = listaDados2;
            //}

            //dr.Close();

            cn.Close();

            return retorno;
        }

        public String DeletarTabelaTemporariaDetalhes()
        {
            String retorno = "";
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
                //comando de instrução do banco de dados
                cmd.CommandText = @"Truncate table tb_temp_detalhes_contasPagar";

                cmd.ExecuteNonQuery();

                retorno = "OK";
            }
            catch (Exception ex)
            {
                retorno = "ERRO";
            }

            cn.Close();
            return retorno;
        }

        public Obra ConsultarObra(String id)
        {

            List<Cliente> listaCliente = new List<Cliente>();
            Obra obra = new Obra();

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


            //comando de instrução do banco de dados
            cmd.CommandText = @"SELECT TOP (1000) id_obra
                               ,o.desc_obra
                               ,o.id_cliente
                               ,o.cep
                               ,o.logradouro
                               ,o.numero
                               ,o.complemento
                               ,o.bairro
                               ,o.cidade
                               ,o.uf
                               ,responsavel
                               ,dt_inicio_obra
                               ,dt_fim_obra
                               ,valor
                               ,o.nm_cadastrou
                               ,o.dt_cadastrou, cliente.RazaoSocial
                                FROM obra o
                                inner join tb_cliente cliente on cliente.id = o.id_cliente
                                WHERE o.id_obra = @id";


            cmd.Parameters.AddWithValue("@id", id);

            SqlDataReader dr = cmd.ExecuteReader();


            while (dr.Read())
            {

                obra.id = Convert.ToInt32(dr["id_obra"]);
                obra.nome = dr["desc_obra"].ToString();
                obra.cliente = new Cliente { id = Convert.ToInt32(dr["id_cliente"]), RazaoSocial = dr["RazaoSocial"].ToString() };
                obra.endereco = new Endereco { logradouro = dr["logradouro"].ToString(), 
                                               cep = dr["cep"].ToString(), 
                                               bairro = dr["bairro"].ToString(),
                                               numero = dr["numero"].ToString(),
                                               complemento = dr["complemento"].ToString(),
                                               cidade = dr["logradouro"].ToString(),
                                               uf = dr["uf"].ToString() };
                obra.responsavel = dr["responsavel"].ToString();
                obra.valor_string = Convert.ToDouble(dr["valor"]).ToString("N2");
            
            }


            dr.Close();
            cn.Close();

            return obra;
        }





    }
}