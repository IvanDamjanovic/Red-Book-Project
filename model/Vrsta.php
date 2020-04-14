<?php

class Vrsta
{

    public static function traziVrste()
    {
        $veza = DB::getInstanca();
        $izraz = $veza->prepare('
            select a.sifra, b.ime,b.email,
            b.oib from vrsta a inner join ime b
            on a.ime=b.sifra
            where concat(b.ime,\' \',) like :uvjet
            order by b.ime
        ');

        $izraz->execute(['uvjet'=>'%' . $_GET['uvjet'] . '%']);
        return $izraz->fetchAll();
    }

    public static function ukupnoStranica($uvjet)
    {
        $uvjet='%'.$uvjet.'%';
        $veza = DB::getInstanca();
        $izraz = $veza->prepare('

        select * from vrsta 

        ');
        $izraz->bindParam('uvjet',$uvjet);
        $izraz->execute();
        $ukupnoRezultata=$izraz->fetchColumn();
        return ceil($ukupnoRezultata / App::config('rezultataPoStranici'));
    }

    public static function trazi($uvjet,$stranica)
    {
        $rps = App::config('rezultataPoStranici');

        $od = $stranica * $rps - $rps;


        $uvjet='%'.$uvjet.'%';
        $veza = DB::getInstanca();
        //odrediti broj prikaza na jednoj stranici
        $izraz = $veza->prepare('
        
        select * from vrsta 

        ');
        $izraz->bindParam('uvjet',$uvjet);
        $izraz->bindValue('od',$od, PDO::PARAM_INT);
        $izraz->execute();

        return $izraz->fetchAll();
    }

    public static function readAll()
    {
        $veza = DB::getInstanca();
        $izraz = $veza->prepare('

        select a.sifra, a.ime, b.ime, 
        b.kategorija, b.istrazivac, b.ugrozenost, 
        count(c.projekt) as ukupno
        from vrsta a left join vrsta b  on a.vrsta=b.sifra
        left join vrsta c on a.sifra=c.vrsta
        group by a.sifra, a.ime, b.ime, 
        b.kategorija, b.istrazivac, b.ugrozenost

        ');
        $izraz->execute();
        return $izraz->fetchAll();
    }

    public static function read($sifra)
    {
        $veza = DB::getInstanca();
        $izraz = $veza->prepare('
        select a.sifra, a.ime, b.ime, 
        b.kategorija, b.istrazivac, b.ugrozenost
        from vrsta a left join vrsta b  on a.vrsta=b.sifra
        where a.sifra=:sifra
        ');
        $izraz->execute(['sifra'=>$sifra]);
        return $izraz->fetch();
    }

    public static function create()
    {
        $veza = DB::getInstanca();
        $veza->beginTransaction();

        $izraz=$veza->prepare('insert into vrsta 
        (ime,kategorija,istrazivac,ugrozenost) values 
        (:ime,:kategorija,:istrazivac,:ugrozenost)');
        $izraz->execute([
            'ime' => $_POST['ime'],
            'kategorija' => $_POST['kategorija'],
            'istrazivac' => $_POST['istrazivac'],
            'ugrozenost' => $_POST['ugrozenost']
        ]); 

        $zadnjaSifra = $veza->lastInsertId();

        
        $izraz=$veza->prepare('insert into vrsta 
        (ime,kategorija) values 
        (:ime,:kategorija)');
        $izraz->execute([
            'ime' => $_POST['ime'],
            'kategorija' => $_POST['kategorija']
        ]); 
        
        
        $veza->commit();
    }

    public static function delete()
    {
        try{
            $veza = DB::getInstanca();
            $veza->beginTransaction();
            $izraz=$veza->prepare('select ime
            from vrsta  
            where sifra=:sifra');
            $izraz->execute($_GET);

            $sifraime = $izraz->fetchColumn();

            $izraz=$veza->prepare('delete from vrsta 
            where sifra=:sifra');
            $izraz->execute($_GET);


            $izraz=$veza->prepare('delete from ime 
            where sifra=:sifra');
            $izraz->execute(['sifra'=>$sifraime]);


            $veza->commit();
        }catch(PDOException $e){
            echo $e->getMessage();
            return false;
        }
        return true;
    }

    public static function update(){
        $veza = DB::getInstanca();
        
        
        $izraz=$veza->prepare('update vrsta 
        set ime=:ime, kategorija=:kategorija,
        istrazivac=:istrazivac,ugrozenost=:ugrozenost
        where sifra=:sifra');
        $izraz->execute([
            'ime' => $_POST['ime'],
            'kategorija' => $_POST['kategorija'],
            'istrazivac' => $_POST['istrazivac'],
            'ugrozenost' => $_POST['ugrozenost'],
            'sifra' => $_POST['sifra']
        ]); 
    }
}