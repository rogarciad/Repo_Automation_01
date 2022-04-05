#!/bin/bash
PROJECT="crp-dev-iac-testing"
BKT="bkt09"
LIST_BK=$(gsutil ls | grep $BKT | wc -l)
llenado_datos(){
echo $LIST_BK
if [ $LIST_BK != 0 ]; then
        echo "Existe bucket:" $PROJECT-$BKT
else
        echo "No existe el bucket, a continuación se generara..."
        gsutil mb -p $PROJECT -c STANDARD -l US -b on gs://$PROJECT-$BKT
        sleep 5
        gsutil label ch -l grupo:grupo-02 gs://$PROJECT-$BKT
        sleep 5
        gsutil label ch -l proyecto:golondrinas gs://$PROJECT-$BKT
        echo "Bucket generado con exito y etiquetas asignadas"
fi
touch ./sinceramente.txt
for i in {1..100};do
        gsutil cp sinceramente.txt gs://$PROJECT-$BKT/grupo-02/carpeta-$i/
done
}

encuentra_files_no_vacios(){
        for i in {1..100};do
                SIZE=$(gsutil du gs://crp-dev-iac-testing-bkt09/grupo-02/carpeta-$i/sinceramente.txt | awk '{print $1}')
                if [ $SIZE != 0 ];then
                 echo "Carpeta con datos: gs://crp-dev-iac-testing-bkt09/grupo-02/carpeta-$i"
                fi
        done
}


llenado_datos
encuentra_files_no_vacios
