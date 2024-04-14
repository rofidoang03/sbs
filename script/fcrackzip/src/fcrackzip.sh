#!/bin/bash
# ------------------------------------------------------------
# + Alat      : Fcrackzip
# + Deskripsi : Fcrackzip adalah alat yang digunakan untuk
#               membuka (crack) file zip yang terenkripsi
#               dengan kata sandi.
# + Pembuat   : Rofidoang03
# ------------------------------------------------------------
# + Github         : https://github.com/rofidoang03/sbs
# ------------------------------------------------------------

# variabel warna 
b="\e[1;34m" # biru terang
m="\e[1;31m" # merah terang 
h="\e[1;32m" # hijau terang 
p="\e[1;37m" # putih terang 
c="\e[1;36m" # cyan terang
r="\e[;0m"   # reset

# membersihkan layar terminal
	clear

# fungsi mengecek apakah alat fcrackzip sudah terinstal apa belum
function cek_alat(){
	if ! command -v fcrackzip >> /dev/null 2>&1; then
		echo -e "${m}[-] ${p}Alat Fcrackzip belum diinstal.${r}"
		echo -e "${p}[${c}info${p}] Untuk menginstalnya ketikkan perintah '${c}sudo apt-get install fcrackzip${p}'${r}"
	else
		pilih_file_zip
	fi
}

function banner(){

	echo -e ""
	echo -e "${p}[--------------------------------------------------------------]"
    	echo -e "${p}[${c}--${p}]--------------------------------------------------------[${c}--${p}]${r}"
    	echo -e "${p}[${c}--${p}]                      Fcrackzip                         [${c}--${p}]${r}"
	echo -e "${p}[${c}--${p}]              ${c}Dibuat oleh: ${m}Rofi (Fixploit)              ${p}[${c}--${p}]${r}"
	echo -e "${p}[${c}--${p}]                      ${c}Version: ${m}1.0                      ${p}[${c}--${p}]${r}"
	echo -e "${p}[${c}--${p}]  ${c}Ikuti Saya di Github: ${m}https://github.com/rofidoang03  ${p}[${c}--${p}]${r}"
	echo -e "${p}[${c}--${p}]--------------------------------------------------------[${c}--${p}]${r}"
	echo -e "${p}[--------------------------------------------------------------]"
 	echo -e "${r}"
}

# memanggil fungsi banner
	banner

# fungsi untuk memilih file zip yang akan di crack
function pilih_file_zip(){
 
	read -p $'\e[1;37mMasukkan nama file zip: ' file_zip
	if [[ ! -f "${file_zip}" ]]; then
		sleep 1
		echo -e "${m}[-] ${p}File '${m}${file_zip}${p}' tidak ditemukan.${r}"
		pilih_file_zip
	elif [[ -f "${file_zip}" && "${file_zip##*.}" != "zip" ]]; then
		sleep 1
		echo -e "${m}[-] ${p}File '${m}${file_zip}${p}' bukan file zip.${r}"
		pilih_file_zip
	else
		sleep 1
		echo -e "${h}[+] ${p}File zip '${h}${file_zip}${p}' ditemukan.${r}"
		pilih_file_wordlist
	fi
}

# fungsi untuk memilih file wordlist
function pilih_file_wordlist(){
	read -p $'\e[1;37mMasukkan nama file wordlist: ' file_wordlist
	if [[ ! -f "${file_wordlist}" ]]; then
		sleep 1
		echo -e "${m}[-] ${p}File wordlist '${m}${file_wordlist}${p}' tidak ditemukan.${r}"
		pilih_file_wordlist
	else
		sleep 1
		echo -e "${h}[+] ${p}File wordlist '${h}${file_wordlist}${p}' ditemukan.${r}"

		# jumlah password yang terdapat dalam file wordlist.
		jumlah_password=$(wc -l < "${file_wordlist}")

		echo ""
		echo -e "${p}[${c}info${p}] Daftar informasi proses cracking${r}"
		echo ""
		sleep 1
		echo -e "${h}[+] ${p}File zip: ${file_zip}${r}"
		sleep 1
		echo -e "${h}[+] ${p}File wordlist: ${file_wordlist}${r}"
		sleep 1
		echo -e "${b}[*] ${p}Menghitung jumlah password${r}"
		sleep 3
		echo -e "${h}[+] ${p}Jumlah password yang ingin dicoba: ${jumlah_password}${r}"
		echo ""
	
		crack_the_password
	fi
}

# fungsi crack kata sandi file zip
function crack_the_password(){
	read -p $'\e[1;37mApakah Anda ingin memulai proses cracking [iya/tidak]: ' nanya
	if [[ "${nanya}" == "iya" ]]; then
		echo ""
		echo -e "${b}[*] ${p}Menjalankan alat Fcrackzip...${r}"
		sleep 3
		fcrackzip -v -u -D -p "${file_wordlist}" "${file_zip}"
		echo ""
		echo -e "${p}[${c}info${p}] Proses cracking selesai.${r}"
		sleep 1
		read -p $'\e[1;37m[\e[1;36minfo\e[1;37m] Tekan Enter untuk melanjutkan...\e[0m'
                exit 0
	elif [[ "${nanya}" == "tidak" ]]; then
		echo -e "${m}[-] ${p}Proses cracking dibatalkan.${r}"
                exit 1
	else
		echo -e "${m}[-] ${p}Masukkan salah.${r}"
		crack_the_password
	fi
}

# memanggil fungsi cek alat
cek_alat
