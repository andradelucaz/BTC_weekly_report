library(blastula)
library(glue)
library(htmltools)

# Lê o conteúdo do arquivo HTML
html_content <- paste(readLines("btc_report.html", warn = FALSE), collapse = "\n")

email <- compose_email(
  body = htmltools::HTML(
    paste(
      html_content,  
      "<p>Atenciosamente,</p>",
      "<p><strong>Equipe de Análise</strong></p>",
      sep = "\n"
    )
  )
)

my_email <- Sys.getenv("MY_EMAIL")

# blastula::create_smtp_creds_key(
#   id = "gmail",
#   user = my_email,
#   provider = "gmail",
#   use_ssl = TRUE,
#   port = 465,
#   overwrite = TRUE
# )

email_list <- Sys.getenv("EMAIL_LIST")

for (i in email_list) {
# Envia o e-mail
smtp_send(
  email = email,
  from = my_email,
  to = i ,
  subject = "BTC Weekly report",
  credentials = creds_key(id = "gmail")
)
}
