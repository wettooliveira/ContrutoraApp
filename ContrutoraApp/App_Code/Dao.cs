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


                retorno = "OK";
            }
            catch (Exception ex)
            {
                retorno = "ERRO";
            }

            cn.Close();
            return retorno;
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
        public String GravarTempDetalhesDao(Contas Contas)
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
                cmd.CommandText = @"INSERT INTO tb_temp_detalhes_contasPagar(id_conta, desc_detalhe, qtde, valor)
                                    values(@id_conta, @desc_conta, @num_parcela, @valor)";

                cmd.Parameters.AddWithValue("@desc_conta", Contas.desc_conta.ToUpper());
                cmd.Parameters.AddWithValue("@num_parcela", Contas.num_parcela);
                cmd.Parameters.AddWithValue("@valor", Contas.valor);
                cmd.Parameters.AddWithValue("@id_conta", Contas.id_obra);

                cmd.ExecuteNonQuery();
                cn.Close();
                retorno = "OK";
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
                cmd.CommandText = @"insert into tb_temp_detalhes_contasPagar(id_contaPagar,desc_detalhe,qtde,valor)
								select id_contaPagar,desc_detalhe,qtde,valor from tb_detalhes_contasPagar Where id_contaPagar = @id_obra";

                cmd.Parameters.AddWithValue("@id_obra", contas.id_obra);

                cmd.ExecuteNonQuery();
                cmd.Parameters.Clear();
            }

            cmd.CommandText = @"SELECT id_temp_detalhes_contasPagar, desc_detalhe, qtde, valor, total FROM tb_temp_detalhes_contasPagar 
                                OUTER APPLY(select sum(valor*qtde) as total from tb_temp_detalhes_contasPagar)total  
                                WHERE id_contaPagar = @id_obra
                                ORDER BY 1 DESC";                           
                             
            cmd.Parameters.AddWithValue("@id_obra", contas.id_obra);

            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.HasRows)
            {
                while (dr.Read())
                {
                    Contas dadosTabelaDetalhes = new Contas();
                    dadosTabelaDetalhes.id = Convert.ToInt32(dr["id_temp_detalhes_contasPagar"]);
                    dadosTabelaDetalhes.desc_conta = dr["desc_detalhe"].ToString();
                    dadosTabelaDetalhes.tipo = dr["qtde"].ToString();
                    dadosTabelaDetalhes.valor = Convert.ToDouble(dr["valor"]);
                    dadosTabelaDetalhes.valor_string = Convert.ToDouble(dr["total"]).ToString("N2");
                    //soma += Convert.ToDouble(dr["valor"]);
                    //dadosTabelaDetalhes.valor_string = soma.ToString("N2");

                    listaDados1.Add(dadosTabelaDetalhes);
                    retorno.listaContas1 = listaDados1; 
                }
            }
            else
            {
                Contas c = new Contas();
                c.desc_conta = "vazio";
                listaDados1.Add(c);
                retorno.listaContas1 = listaDados1;
            }

            dr.Close();
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


    }
}