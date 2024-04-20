#!/bin/bash
# 

# variabel warna
b="\e[1;34m" # biru terang
m="\e[1;31m" # merah terang
h="\e[1;32m" # hijau terang
p="\e[1;37m" # putih terang
k="\e[1;33m" # kuning terang
c="\e[1;36m" # cyan terang
r="\e[;0m"   # reset

clear

# fungsi banner
function banner(){

    echo -e ""
    echo -e "${p}[--------------------------------------------------------------]"
        echo -e "${p}[${c}--${p}]--------------------------------------------------------[${c}--${p}]${r}"
        echo -e "${p}[${c}--${p}]                         SBS                            [${c}--${p}]${r}"
    echo -e "${p}[${c}--${p}]              ${c}Dibuat oleh: ${m}Rofi (Fixploit)              ${p}[${c}--${p}]${r}"
    echo -e "${p}[${c}--${p}]                      ${c}Version: ${m}1.0                      ${p}[${c}--${p}]${r}"
    echo -e "${p}[${c}--${p}]  ${c}Ikuti Saya di Github: ${m}https://github.com/rofidoang03  ${p}[${c}--${p}]${r}"
    echo -e "${p}[${c}--${p}]--------------------------------------------------------[${c}--${p}]${r}"
    echo -e "${p}[--------------------------------------------------------------]"
    echo -e "${r}"
}

# fungsi pilih kategori alat
function pilih_kategori_alat(){
    clear
    banner
	echo -e "${p}[${c}info${p}] Daftar kategori alat yang tersedia:${r}"
	echo ""
	echo -e " ${p}[ ${k}0 ${p}] Perbaharui SBS (${m}Update SBS${p})${r}"
	echo -e " ${p}[ ${k}1 ${p}] Pengumpulan informasi (${m}Information gathering${p})${r}"
	echo -e " ${p}[ ${k}2 ${p}] Analisis kerentanan (${m}Vulnerability analysis${p})${r}"
	echo -e " ${p}[ ${k}3 ${p}] Analisi aplikasi web (${m}Web application analysis${p})${r}"
	echo -e " ${p}[ ${k}4 ${p}] Alat-alat eksploitasi (${m}Exploitation tools${p})${r}"
	echo -e " ${p}[ ${k}5 ${p}] Memelihara akses (${m}Maintaining access${p})${r}"
	echo -e " ${p}[ ${k}6 ${p}] Pasca eksploitasi (${m}Post exploitation${p})${r}"
	echo -e " ${p}[ ${k}7 ${p}] Serangan sandi (${m}Password attacks${p})${r}"
	echo -e " ${p}[ ${k}8 ${p}] Pengujian nirkabel (${m}Wireless testing${p})${r}"
	echo -e " ${p}[ ${k}9 ${p}] Penyadapan dan pemalsuan (${m}Sniffing and spofoofing${p})${r}"
	echo -e "${p}[ ${k}10 ${p}] Forensik digital (${m}Digital forensics${p})${r}"
	echo -e "${p}[ ${k}11 ${p}] Otomotif (${m}Automotive${p})${r}"
	echo -e "${p}[ ${k}12 ${p}] Rekayasa balik (${m}Reverse engineering${p})${r}"
	echo -e "${p}[ ${k}13 ${p}] Alat pelaporan (${m}Reporting tools${p})${r}"
	echo -e "${p}[ ${k}99 ${p}] Keluar (${m}Exit${p})${r}"
	echo ""


	# fungsi pilih kategori
	function pilih_kategori(){
		read -p $'\e[1;37mSilahkan pilih jenis kategori alat apa yang ingin Anda ingin gunakan: ' pka

		if [[ "${pka}" == "7" ]]; then
			serangan_sandi
		else
			echo "[-] Jenis kategori alat yang Anda pilih tidak tersedia. Silahkan pilih jenis kategori alat yang tersedia."
			pilih_kategori
		fi
	}
	pilih_kategori

}

# fungsi kategori alat pengumpulan informasi

# fungsi kategori alat analisis kerentanan

# fungsi analisi aplikasi web

# fungsi alat-alat eksploitasi

# fungsi memelihara akses

# fungsi pasca eksploitasi

# fungsi serangan sandi
function serangan_sandi(){
	echo ""
	echo -e "${p}[${c}info${p}] Daftar alat-alat yang terdapat dalam kategori serangan password:${r}"
	echo ""
	echo -e " ${p}[ ${k}0 ${p}] Kembali ke kategori alat${r}"
	echo -e " ${p}[ ${k}1 ${p}] Fcrackzip${r}"
 	echo -e " ${p}[ ${k}2 ${p}] Johnny${r}"
	echo -e "${p}[ ${k}99 ${p}] Keluar${r}"
	echo ""

	# fungsi memilih alat kategori serangan sandi
	function mass(){
		read -p $'\e[1;37mSilahkan pilih alat yang ingin Anda gunakan: ' pass

		if [[ "${pass}" == "0" ]]; then
			pilih_kategori_alat
		elif [[ "${pass}" == "1" ]]; then
			bash script/password_attack/fcrackzip.sh
   		elif [[  "${pass}" == "2" ]]; then
     			bash script/password_attack/johnny.sh
		elif [[ "${pass}" == "99" ]]; then
			echo ""
			echo "[info] Terimakasih telah menggunakan SBS."
			echo ""
			exit 0
		else
			echo "[-] Alat yang ingin Anda gunakan tidak tersedia. Silahkan pilih alat yang tersedia."
			mass
		fi
			
	}
	
	mass	
}

pilih_kategori_alat
