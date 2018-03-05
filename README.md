# Kviz
MMS - Završni projekt


Popis članova tima: Branimir Jungić, Mislav Kuzmić, Ivana Senkić

Opis projekta:
U planu nam je napraviti igricu koja će se sastojati od više razina i više različitih vrsta audio-vizualnih pitanja iz opće kulture, pitanja koja od igrača očekuju snalažljivost, preciznost i brzinu. Igra će imati Top listu igrača s obzirom na osvojen broj bodova, a pokušat ćemo napraviti i opciju da više od jednog igrača igra u isto vrijeme.
Za prezentaciju projekta je potrebno računalo, monitor i tipkovnica.

Korišteni programski jezik: Processing 3

Potrebni library-i: ControlP5
					Minim
					Video
					
Upute za pokretanje i korištenje:
	- Otvoriti mapu server i u njoj pokrenuti server.pde
	- Otvoriti mapu client i u njoj otvoriti client.pde
		- U client.pde, otići na liniju 70 serverAddress i potrebi je promijeniti (ovo planiramo napraviti da se zadaje preko TextBoxa
		- Nakon eventualne promjene serverAddress, pokrenuti client.pde
	- Otvara se početni zaslon za klijenta/igrača.
	- Prikazuje je polje za unos imena i tri gumba.
	- Gumb Highscore: Klikom miša na gumb Highscore otvara se novi zaslon gdje su prikazani najbolji igrači i gumb Nazad. Klikom miša na taj gumb vraćamo se na početni zaslon.
	- Gumb Zatvori: zatvara client.pde
	- Gumb Počni!: Ukoliko se igrač želi prijaviti na igru, mora prvo unijeti svoje ime u za to predviđeno polje, a zatim klikom miša ili pritiskom tipke Enter se prijavi za igru. Ako se radi o uspješnoj prijavi, klijent dobiva povratnu poruku na zaslonu.
	- Pogledamo početni zaslon od server.pde. Imamo dva gumba.
	- Gumb Zatvori: zatvara server.pde.
	- Gumb Pokreni: pokreće igru.
	- Također u prozoru vidimo sve igrače koji su se prijavili na igru. Kad se željeni broj igrača prijavi, pritisnemo gumb Pokreni i prebacujemo se u client.pde
	- U prozoru nam se generiraju pitanja koja mogu obična pitanja, video pitanja (npr. kojoj seriji pripada sljedeći video), pitanja sa slikom (npr. koja je životinja na slici), pitanja sa zvukom (npr. koja je ovo skladba) i bonus pitanja(npr. koliko je 2+2). Na pitanja odgovaramo pritiskom tipki A,S,D,F. U kućicama gdje se nalaze odgovori piše koje slovo trebamo pritisnuti da bismo odabrali odgovor u toj kućici. Za svako pitanje imamo 10 sekundi da odgovor.
	Nakon što odgovorimo na pitanje, kućica našeg odgovora požuti i moramo pričekati da istekne vrijeme kako bi dobili novo pitanje. Svi igrači koji su odgovorili točno dobivaju 10 bodova. Međutim, ako je riječ o bonus pitanju, tada samo onaj igrač koji je prvi odgovorio dobiva bodove. Također, kod bonus pitanja ne čekamo da istekne vrijeme, već da netko prvi točno odgovori (ako već to mi nismo bili).
	- Server trenutno generira 10 pitanja i nakon što izgenerira svih 10, klijentu se prikazuje novi zaslon na kojem pišu osvojeni bodovi i nacrtaju se tri gumba: Nazad, Ponovni igraj, Zatvori.
	- Klikom miša na Zatvori client.pde se zatvara.
	- Klikom miša na Nazad vraćamo se na početni zaslon i kao prije se prijavljujemo za igru.
	- Klikom miša na Ponovno igraj, s istim imenom kao i prije se ponovno prijavljujemo za igru. Opet na serveru trebamo pritisnuti gumb Pokreni da igru započnemo.
