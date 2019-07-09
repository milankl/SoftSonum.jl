function fillSonumTables(nbit::Int)

    # start with the lists - the fast bit
    fillListInv(nbit)
    fillListSqrt(nbit)
    fillTable(nbit,(+))
    fillTable(nbit,(-))
    fillTable(nbit,(*))
end

function fillTable(nbit::Int,operator)

    if nbit == 8
        sonum = sonum8
        Float2Sonum = Sonum8
    elseif nbit == 16
        sonum = sonum16
        Float2Sonum = Sonum16
    else
        throw(error("Only 8/16bit supported."))
    end

    # fill the underlying matrices not the symmetric views
    if operator == (+)
        if nbit == 8
            table = TableAdd8
        elseif nbit == 16
            table = TableAdd16
        end
    elseif operator == (-)
        if nbit == 8
            table = TableSub8
        elseif nbit == 16
            table = TableSub16
        end
    elseif operator == (*)
        if nbit == 8
            table = TableMul8
        elseif nbit == 16
            table = TableMul16
        end
    else
        throw(error("No $operator table defined."))
    end

    n = length(sonum)
    for i in 1:n
        for j in 1:n
            if j >= i      # only upper triangle elements (symmetric or antisymmetric)
                table[i,j] = Float2Sonum(operator(sonum[i],sonum[j]))
            end
        end
    end
end

function fillListSqrt(nbit::Int)
    if nbit == 8
        sonum = sonum8
        ListSqrt = ListSqrt8
        Float2Sonum = Sonum8
    elseif nbit == 16
        sonum = sonum16
        ListSqrt = ListSqrt16
        Float2Sonum = Sonum16
    else
        throw(error("Only 8/16bit supported."))
    end

    for i in 1:length(sonum)
        ListSqrt[i] = Float2Sonum(sqrt(sonum[i]))
    end
end

function fillListInv(nbit::Int)
    if nbit == 8
        sonum = sonum8
        ListInv = ListInv8
        Float2Sonum = Sonum8
    elseif nbit == 16
        sonum = sonum16
        ListInv = ListInv16
        Float2Sonum = Sonum16
    else
        throw(error("Only 8/16bit supported."))
    end

    for i in 1:length(sonum)
        ListInv[i] = Float2Sonum(1/sonum[i])
    end
end
