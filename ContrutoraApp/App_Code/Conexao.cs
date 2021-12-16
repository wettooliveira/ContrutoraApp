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
                return @"Data Source= DESKTOP-97L1SFR\BD; Initial Catalog= Construtora; Integrated Security= True; Connect Timeout= 30; User= DESKTOP-97L1SFR\user; Password= ";
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
