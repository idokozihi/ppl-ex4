/*
 * **********************************************
 * Printing result depth
 *
 * You can enlarge it, if needed.
 * **********************************************
 */
maximum_printing_depth(100).

:- current_prolog_flag(toplevel_print_options, A),
   (select(max_depth(_), A, B), ! ; A = B),
   maximum_printing_depth(MPD),
   set_prolog_flag(toplevel_print_options, [max_depth(MPD)|B]).

% Signature: sub_list(Sublist, List)/2
% Purpose: All elements in Sublist appear in List in the same order.
% Precondition: List is fully instantiated (queries do not include variables in their second argument).
sub_list([], []).
sub_list([], [_ | _]).
sub_list([X | Xs], [X | Ys]) :- sub_list(Xs, Ys).
sub_list(Xs, [_ | Ys]) :- sub_list(Xs, Ys).






% Signature: append_lists(L1, L2, L3)/3
% Purpose: similar to prologs "append". for example: append_lists([1,2],[3,4],T). T = [1,2,3,4].
% Sub-procedure for SEIF 2.B
append_lists([], L2, L2).
append_lists([L1 | L1s], L2, [L1 | L3s]) :- append_lists(L1s, L2, L3s).

% Signature: swap_list(List, InversedList)/2
% Purpose: InversedList is the ‘mirror’ representation of List, i.e, each item in the list is recursively replaced with the item at the position, with refers to the beginning and the end of the list.   
swap_list([], []).
swap_list([[Y | Ys] | Xs], InversedList) :-
    !, % dont reach next procedure if this one fails.
    swap_list(Xs, InversedXs),
    swap_list([Y | Ys], InversedY),
    append_lists(InversedXs, [InversedY], InversedList).
swap_list([X | Xs], InversedList) :-
    swap_list(Xs, InversedXs),
    append_lists(InversedXs, [X], InversedList).




% Signature: sub_tree(Subtree, Tree)/2
% Purpose: Tree contains Subtree.
sub_tree(tree(Tx, Tl, Tr), tree(Tx, Tl, Tr)).
sub_tree(Subtree, tree(_, Tl, _)) :- sub_tree(Subtree, Tl).
sub_tree(Subtree, tree(_, _, Tr)) :- sub_tree(Subtree, Tr).


% Signature: swap_tree(Tree, InversedTree)/2
% Purpose: InversedTree is the �mirror� representation of Tree.
swap_tree(void, void).
swap_tree(tree(Tx, T1l, T1r), tree(Tx, T2l, T2r)) :-
    swap_tree(T1l, T2r),
    swap_tree(T1r, T2l).

