using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


namespace ContrutoraApp
{
    public class Conexao
    {
        public static string StrConexao
        {
            get
            {
              //  return @"Data Source=DESKTOP-0RKSTU6\\SQLEXPRESS;Initial Catalog=Sistema-Wellington; Integrated Security=True; Connect Timeout=30; User=DESKTOP-0RKSTU6\\Wellington;Password=";
                return @"Data Source= BRSAVENDL101377; Initial Catalog= CONSTRUTORA; Integrated Security= True; Connect Timeout= 30; User= BFUSA\OliveiraWel; Password= ";
            }
        }

        public static string conexaoSql
        {
            get
            {
                return @"";
            }
        }
    }


}
