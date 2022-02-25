<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="menunovo.aspx.cs" Inherits="ContrutoraApp.menunovo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <link rel="stylesheet" type="text/css" href="../Css/Content/bootstrap.min.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="../Css/style.css" media="screen" />
    <%--<link rel="stylesheet" type="text/css" href="../Css/Menu.css" media="screen" />--%>
    <link href="~/favicon.ico" rel="shortcut icon" type="image/x-icon" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />



    <title></title>
</head>

<body>
    <style>
        #nav {
            list-style: none inside;
            margin: 0;
            padding: 25px;
            text-align: center;
            width: 100%;
            background-color: #343434;
           
           
            
        }

            #nav li {
                display: block;
                position: relative;
                float: left;
                background-color: #343434;
               
               
                /* menu background color */
            }

                #nav li a {
                    display: block;
                    padding: 0;
                    text-decoration: none;
                    width: 100px;
                    /* this is the width of the menu items */
                    line-height: 35px;
                    /* this is the hieght of the menu items */
                    color: #ffffff;
                    opacity:0.6;
                  
                   
                 
                    /* list item font color */
                }

                #nav li li a {
                    font-size: 90%;
                }

                /* smaller font size for sub menu items */

                #nav li:hover {
                                    
                  
                }

                  #nav li a:hover {
                                    
                  opacity:0.9;
                }

            /* highlights current hovered list item and the parent list items when hovering over sub menues */
            
            #nav ul {
                position: absolute;
                padding: 0;
                left: 0;
                display: none;
                /* hides sublists */
            }

            #nav li:hover ul ul {
                display: none;
                
                
            }

            /* hides sub-sublists */

            #nav li:hover ul {
                display: block;
               
            }

            /* shows sublist on hover */

            #nav li li:hover ul {
                display: block;
                /* shows sub-sublist on hover */
                margin-left: 100px;
                /* this should be the same width as the parent list item */
                margin-top: -35px;
                /* aligns top of sub menu with top of list item */
                
            }

        
    </style>
    <div style="height: 60px; display: inline-flex; width: 100%; position:fixed; ">
        <div style="height: 60px; background-color: #343434; width: 10%; color:white">
            <img runat="server" src="~/Imagens/proibido.png" style="width:40px;position:center; padding-top:8px"/>
        </div>
        <div style="height: 60px; background-color: #343434; width: 85%">
            <ul id="nav">

                <li><a href="#">HOME</a></li>
                <li><a href="#">CADASTROS</a>
                    <ul>
                        <li><a href="#">Sub Item</a></li>
                        <li><a href="#">Sub Item</a></li>
                        <li><a href="#">SUB SUB LIST »</a>
                            <ul>
                                <li><a href="#">Sub Sub Item 1</a>
                                    <li><a href="#">Sub Sub Item 2</a>
                            </ul>
                        </li>
                    </ul>
                </li>
                 <li><a href="#">FINANCEIRO</a>
                    <ul>
                        <li><a href="#">Sub Item</a></li>
                        <li><a href="#">Sub Item</a></li>
                        <li><a href="#">SUB SUB LIST »</a>
                            <ul>
                                <li><a href="#">Sub Sub Item 1</a>
                                    <li><a href="#">Sub Sub Item 2</a>
                            </ul>
                        </li>
                    </ul>
                </li>
                <li><a href="#">Main Item 3</a></li>
            </ul>
        </div>

        <div style="height: 60px; background-color:#343434; width:5%;color:white; align-items:center">
          <img runat="server" src="~/Imagens/list.png" style="width:40px;position:center; padding-top:8px"/>
        </div>

    </div>


</body>

</html>
