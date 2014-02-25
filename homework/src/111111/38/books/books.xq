<sales>{
let $doc := doc("../../../tests/books/books.xml")
for $shop in $doc//shop
    let $shop_name := $shop/@name
    return 
        <shop name="{data($shop_name)}">{
            for $book in $doc//book return 
                if ($book/source=$shop_name) then 
                    for $sold_amount in $shop/sold return 
                            if($sold_amount/@title=$book/title) then
                                <book title="{data($book/title)}" turnover="{data(xs:decimal($book/@price)*$sold_amount/@amount)}" price="{data($book/@price)}" amount="{data($sold_amount/@amount)}" />
                            else ()
            else ()
        }</shop>
}</sales>
