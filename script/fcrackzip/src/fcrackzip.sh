#!/bin/bash
# ------------------------------------------------------------
# + Nama Alat      : Fcrackzip
# + Deskripsi Alat : Fcrackzip adalah alat yang digunakan untuk
#                  membuka (crack) file zip yang terenkripsi
#                  dengan kata sandi.
# + Pembuat        : Rofidoang03
# ------------------------------------------------------------
# + Github         : https://github.com/rofidoang03/sbs
# ------------------------------------------------------------

# membersihkan layar terminal
clear

# fungsi mengecek apakah alat fcrackzip sudah terinstal apa belum
function cek_alat(){
	if ! command -v fcrackzip >> /dev/null 2>&1; then
		echo "[-] Alat Fcrackzip belum diinstal."
		echo "[info] Untuk menginstalnya ketikkan perintah 'sudo apt-get install fcrackzip'"
	else
		pilih_file_zip
	fi
}

# fungsi untuk memilih file zip yang akan di crack
function pilih_file_zip(){
	read -p "Masukkan nama file zip: " file_zip
	if [[ ! -f "${file_zip}" ]]; then
		sleep 1
		echo "[-] File '${file_zip}' tidak ditemukan."
		pilih_file_zip
	elif [[ -f "${file_zip}" && "${file_zip##*.}" != "zip" ]]; then
		sleep 1
		echo "[-] File ${file_zip} bukan file zip."
		pilih_file_zip
	else
		sleep 1
		echo "[+] File zip '${file_zip}' ditemukan."
		pilih_file_wordlist
	fi
}

# fungsi untuk memilih file wordlist
function pilih_file_wordlist(){
	read -p "Masukkan nama file wordlist: " file_wordlist
	if [[ ! -f "${file_wordlist}" ]]; then
		sleep 1
		echo "[-] File wordlist '${file_wordlist}' tidak ditemukan."
		pilih_file_wordlist
	else
		sleep 1
		echo "[+] File wordlist '${file_wordlist}' ditemukan."

		# jumlah password yang terdapat dalam file wordlist.
		jumlah_password=$(wc -l < "${file_wordlist}")

		echo ""
		echo "[info] Daftar informasi proses cracking"
		echo ""
		sleep 1
		echo "[+] File zip: ${file_zip}"
		sleep 1
		echo "[+] File wordlist: ${file_wordlist}"
		sleep 1
		echo "[*] Menghitung jumlah password"
		sleep 3
		echo "[+] Jumlah password yang ingin dicoba: ${jumlah_password} password"
		echo ""
	
		crack_the_password
	fi
}

# fungsi crack kata sandi file zip
function crack_the_password(){
	read -p "Apakah Anda ingin memulai proses cracking [iya/tidak]: " nanya
	if [[ "${nanya}" == "iya" ]]; then
		echo ""
		echo "[*] Menjalankan alat Fcrackzip..."
		sleep 3
		fcrackzip -v -u -D -p "${file_wordlist}" "${file_zip}"
		echo ""
		echo "[info] Proses cracking selesai."
		sleep 1
		read -p "[info] Tekan Enter untuk melanjutkan..."
                exit 0
	elif [[ "${nanya}" == "tidak" ]]; then
		echo "[-] Proses cracking dibatalkan."
                exit 1
	else
		echo "[-] Masukkan salah."
		crack_the_password
	fi
}

# memanggil fungsi cek alat
cek_alat
