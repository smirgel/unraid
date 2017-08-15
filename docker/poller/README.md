# External IP poller

    docker build -t unraid .
    docker run --rm --name unraid -it -e FTP_HOST=smirgel.com -e FTP_USER=smirgel.com -e FTP_PASSWORD=$ftp_pass unraid
