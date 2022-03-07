#!/usr/bin/env bash

# plugins bash moderen
. lib/moduler.sh
# depencies
Bash.import: text_display/colorama text_display/IO.ECHO
Bash.import: util/IO.FUNC util/io.class
Bash.import: util/IO.SYSTEM.var util/IO.TYPE
Bash.import: util/tryCatch

# author : polygon

def: sub_array(){
	var subsrow : "$1";%% variable subsrow nya
	var tentukan : 0; # untuk menentukan batas berhenti
	var finis : 0; # validasi ke dua

	if [[ $subsrow -lt 7 ]]; then
		var dummy : ""; %% benar subsrow lebih kacil dari angka 7
	else
		println_info " subsrow tidak boleh melebihi angka 7\n\n"
		exit
	fi
	
	while ((tentukan<subsrow)); do
		let tentukan++
		let finis++

		if [[ $tentukan == $finis ]]; then
			# system validasi subsrow simple
			read -p "masukan element $tentukan : " s
			# memparse space menjadi koma ,
			var set_element : $(echo "$s" | sed 's;[[:space:]];, ;g')
			# menyimpan hasil parse ke file dump_(jumlah row).txt
			echo "[[$set_element]], " > dump_$tentukan.txt
		fi

			declare subsrow_sys+=$(cat dump_$tentukan.txt);%% simpan ke variable untuk di panggil += tidak akan menimpa

			if [[ $tentukan == $subsrow ]]; then
				var file : 0
				for x in $(seq 1 $subsrow); do
					let file++
					rm -rf dump_$file.txt &> /dev/null
					%% menghapus file dump_(jumlah row).txt
				done; echo
					var regex_array : ${subsrow_sys%%, };%% menghapus koma dan spasi di bagian akhir
					println_info " hasil\n"
					Tulis.strN "[$regex_array]\n";# cetak hasil ke display
					break; # berhenti
			fi; %% penutup statement if
			
	done; # penutup statement loop while
}

Namespace: array.sh
{
	def: main(){
		echo
		Tulis.strN "• Author       : Bayu riski A.M (Speedrun|silent)"
		Tulis.strN "• Language     : Bash (Bourne again shell)"
		Tulis.strN "• github       : Bayu12345677"
		Tulis.strN "• contributor  : DemonNipon\n"
		Tulis.str "masukan subrow (maxsimum 7) : "
		read row; echo

			[[ -z "$row" ]] && { echo;println_info " row tidak boleh kosong minimal 7"; echo;exit; }
		    sub_array "$row";
		    	Tulis.str "ingin input row berikut nya y/n : "
		    	read input

		    	if [[ $input == y ]]; then
		    		main
		    	elif [[ $input == n ]]; then
		    		Tulis.strN "[-] Keluar\n"; exit
		    	fi
	};main
};
