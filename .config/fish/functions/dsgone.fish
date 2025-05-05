function dsgone
    for x in (fd -uuu '\.DS_Store')
        rm $x
        echo $x
    end
end
