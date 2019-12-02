| INPUT | OUTPUT | KETERANGAN |
| --- | --- | --- |
| `(null)` | "[TIDAK VALID] Silahkan Isi! Tidak boleh kosong" | Tanpa Input |
| `ka` | "[TIDAK VALID] Karakter tidak cukup!" | < 3 character |
| `katongilangbagas.com` | "[TIDAK VALID] Anda mengetik terlalu banyak!" | > 15 character |
| `katongilang` | "[TIDAK VALID] Domain harus memiliki ekstensi!"		|	Tanpa extension tld |
| `katon gilang.net` | "[TIDAK VALID] Domain hanya boleh mengandung karakter alphanumerik, dot, dan dash!" |		Salah format domain |
| `katongilang.xxx` | "[TIDAK VALID] Bukan extension domain yang benar!" | tld tidak sesuai |
| `[namadomain].[tld]` | "[TIDAK VALID] Domain telah terdaftar" | domain random utk avaliablity |
