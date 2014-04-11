<sales>{
let $doc := doc("books.xml")
for $shop in $doc//shop
    let $shop_name := $shop/@name
    return
        <shop name="{data($shop_name)}">{
            for $book in $doc//book return
                if ($book/source=$shop_namt/@amount)}" price="{data($book/@price)}" amount="{data($sold_amount/@amount)}" />
                            else ()
            else ()
        }</shop>
}</sales>
