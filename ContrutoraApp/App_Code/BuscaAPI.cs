using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace ContrutoraApp
{
    public class BuscaAPI
    {
        public Endereco BuscaCEP(string cep)
        {


            int contagemNumerosCEP = cep.Length;

            Endereco ende = new Endereco();

            if ((!cep.Equals("")) && (contagemNumerosCEP == 8 || contagemNumerosCEP == 9))
            {
                //Cria um DataSet  baseado no retorno do XML  
                DataSet ds = new DataSet();
                ds.ReadXml("http://viacep.com.br/ws/" + cep.Replace(" - ", "").Trim() + "/xml/");

                //Response.Write(ds.Tables[0].Rows[0]["uf"].ToString());
                //Response.End();

                try
                {

                    //Estado estado = new Estado();
                    //Cidade cidade = new Cidade();

                    //estado.uf = ds.Tables[0].Rows[0]["uf"].ToString().Trim().ToUpper();
                    //ende.estado = estado;

                    //cidade.cidade = ds.Tables[0].Rows[0]["localidade"].ToString().Trim().ToUpper();
                    //ende.cidade = cidade;
                    ende.uf = ds.Tables[0].Rows[0]["uf"].ToString().Trim().ToUpper();
                    ende.cidade = ds.Tables[0].Rows[0]["localidade"].ToString().Trim().ToUpper();
                    ende.bairro = ds.Tables[0].Rows[0]["bairro"].ToString().Trim().ToUpper();
                    //ende.tipo_lagradouro = retornaStringSemAcentos(ds.Tables[0].Rows[0]["tipo_logradouro"].ToString().Trim().ToUpper());
                    ende.logradouro = ds.Tables[0].Rows[0]["logradouro"].ToString().Trim().ToUpper();
                    ende.complemento = ds.Tables[0].Rows[0]["complemento"].ToString().Trim().ToUpper();
                    ende.resultato_txt = "CEP completo";

                }
                catch (Exception ex)
                {
                    ende.logradouro = "ERRO";

                }
            }
            else
            {
                ende.logradouro = "ERRO";
            }
            return ende;

        }
    }
}