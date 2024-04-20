#!/bin/bash
# ------------------------------------------------------------
# + Alat      : Fcrackzip
# + Deskripsi : Fcrackzip adalah alat yang digunakan untuk
#               membobol file zip yang terenkripsi
#               dengan kata sandi.
# + Pembuat   : Rofidoang03
# ------------------------------------------------------------
# + Github    : https://github.com/rofidoang03/sbs
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


# fungsi banner 
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
		echo -e "${m}[-] ${p}File '${m}${file_zip}${p}' tidak ditemukan.${r}"
		pilih_file_zip
	elif [[ -f "${file_zip}" && "${file_zip##*.}" != "zip" ]]; then
		echo -e "${m}[-] ${p}File '${m}${file_zip}${p}' bukan file zip.${r}"
		pilih_file_zip
	else
		echo -e "${h}[+] ${p}File zip '${h}${file_zip}${p}' ditemukan.${r}"
		pilih_file_wordlist
	fi
}

# fungsi untuk memilih file wordlist
function pilih_file_wordlist(){
	read -p $'\e[1;37mMasukkan nama file wordlist: ' file_wordlist
	if [[ ! -f "${file_wordlist}" ]]; then
		echo -e "${m}[-] ${p}File wordlist '${m}${file_wordlist}${p}' tidak ditemukan.${r}"
		pilih_file_wordlist
	else
		echo -e "${h}[+] ${p}File wordlist '${h}${file_wordlist}${p}' ditemukan.${r}"

		# jumlah password yang terdapat dalam file wordlist.
		jumlah_password=$(wc -l < "${file_wordlist}")

		echo ""
		echo -e "${p}[${c}info${p}] Daftar informasi proses cracking${r}"
		echo ""
		echo -e "${h}[+] ${p}File zip: ${file_zip}${r}"
		echo -e "${h}[+] ${p}File wordlist: ${file_wordlist}${r}"
		echo -e "${b}[*] ${p}Menghitung jumlah password${r}"
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
                # crack kata sandi file zip menggunakan tools fcrackzip
                password=$(fcrackzip -u -D -p "${file_wordlist}" "${file_zip}" | awk "NR==3")
                # kondisi jika kata sandi file zip tidak ditemukan 
		if [[ -z "${password}" ]]; then
		        echo -e "\n${m}[-] ${p}PASSWORD NOT FOUND!!!!${r}\n"
	        # kondisi jika kata sandi file zip ditemukan 
	        else
	                echo -e "\n${h}[+] ${p}${password}${r}\n"
		fi
		echo -e "${p}[${c}info${p}] Proses cracking selesai.${r}"
		read -p $'\e[1;37m[\e[1;36minfo\e[1;37m] Tekan Enter untuk melanjutkan...\e[0m'
                # kembali ke menu utama 
                bash sbs.sh
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
