%%
%% Copyright (C) 2023 by Jinwen XU
%% -------------------------------
%%
%% This file may be distributed and/or modified under the conditions of
%% the LaTeX Project Public License, either version 1.3c of this license
%% or (at your option) any later version.  The latest version of this
%% license is in:
%%
%%    http://www.latex-project.org/lppl.txt
%%
\NeedsTeXFormat{LaTeX2e}[2022-06-01]
\ProvidesExplClass
  {homework}
  {2023/09/24} {}
  {Document class for writing homework}

\keys_define:nn { homework }
  {
    , logo        .tl_set:N     = \l__homework_logo_name_tl
    , logo        .initial:n    = { }
    , logo-height .dim_set:N    = \l__homework_logo_height_dim
    , logo~height .dim_set:N    = \l__homework_logo_height_dim
    , logo height .dim_set:N    = \l__homework_logo_height_dim

    , unknown     .code:n       = {
                                    \PassOptionsToClass { \CurrentOption } { minimart }
                                    \PassOptionsToClass { \CurrentOption } { einfart }
                                    \PassOptionsToPackage { \CurrentOption } { ProjLib }
                                  }
  }
\ProcessKeyOptions [ homework ]

%%================================
%%  Load the base class
%%================================

\sys_if_engine_pdftex:TF
  {
    \PassOptionsToClass { use style = classical } { minimart }
    \LoadClass { minimart }
  }
  {
    \PassOptionsToClass { use style = classical } { einfart }
    \LoadClass { einfart }
  }

\RequirePackage { ProjLib }

%%================================
%%  Insert the logo
%%================================

\cs_new_protected:Nn \homework_include_logo:nn
  % #1 = height
  % #2 = name
  {
    \includegraphics [ height = #1 ] { #2 }
  }

\AddToHook { begindocument/end }
  {
    \maketitle

    \tl_if_empty:NF \l__homework_logo_name_tl
      {
        \dim_compare:nNnT { \l__homework_logo_height_dim } < { 1pt }
          {
            \dim_set:Nn \l__homework_logo_height_dim { .6\pagetotal }
          }
        \dim_set:Nn \l_tmpa_dim { \pagetotal + .33\baselineskip }
        \vspace { - \l_tmpa_dim }
        \vspace { .5\l_tmpa_dim - .5\l__homework_logo_height_dim }
        \homework_include_logo:nn { \l__homework_logo_height_dim } { \l__homework_logo_name_tl }
        \vspace { .5\l_tmpa_dim - .5\l__homework_logo_height_dim }
      }
  }

%%================================
%%  Page # of ##
%%================================

\projlib_langauge_define_multilingual_text:Nn \l__homework_page_of_total_tl
  {
    , EN = { Page \nobreakspace \,\thepage\, \nobreakspace of \nobreakspace \,\pageref*{LastPage} }
    , FR = { Page \nobreakspace \,\thepage\, \nobreakspace sur \nobreakspace \,\pageref*{LastPage} }
    , DE = { Seite \nobreakspace \,\thepage\, \nobreakspace von \nobreakspace \,\pageref*{LastPage} }
    , IT = { Pagina \nobreakspace \,\thepage\, \nobreakspace di \nobreakspace \,\pageref*{LastPage} }
    , PT = { Página \nobreakspace \,\thepage\, \nobreakspace de \nobreakspace \,\pageref*{LastPage} }
    , BR = { Página \nobreakspace \,\thepage\, \nobreakspace de \nobreakspace \,\pageref*{LastPage} }
    , ES = { Página \nobreakspace \,\thepage\, \nobreakspace de \nobreakspace \,\pageref*{LastPage} }
    , CN = { 第 \,\thepage\, 页，共 \,\pageref*{LastPage}\, 页 }
    , TC = { 第 \,\thepage\, 頁，共 \,\pageref*{LastPage}\, 頁 }
    , JP = { ページ \nobreakspace \,\thepage\, / \,\pageref*{LastPage} }
    , RU = { Страница \nobreakspace \,\thepage\, \nobreakspace из \nobreakspace \,\pageref*{LastPage} }
  }

\RequirePackage { lastpage }
\fancypagestyle { fancy }
  {
    \rfoot{\small\color{main-text!27!paper} \l__homework_page_of_total_tl }
  }
\pagestyle { fancy }

%%================================
%%  Colored solution environment
%%================================

\projlib_langauge_define_multilingual_text:Nn \l__homework_solution_tl
  {
    , EN = { Solution }
    , FR = { Solution }
    , DE = { Lösung }
    , IT = { Soluzione }
    , PT = { Solução }
    , BR = { Solução }
    , ES = { Solución }
    , CN = { 解 }
    , TC = { 解 }
    , JP = { 解答 }
    , RU = { Решение }
  }

\newcommand\soluline{\bgroup\markoverwith{\rule[-.45ex]{2pt}{.75pt}}\ULon}
\NewDocumentEnvironment { solution } { O{ \l__homework_solution_tl } }
  {
    \setlength\abovedisplayskip{.3\baselineskip}
    \setlength\belowdisplayskip{.3\baselineskip}
    \setlength\abovedisplayshortskip{.3\baselineskip}
    \setlength\belowdisplayshortskip{.3\baselineskip}
    \par\noindent
    \color{cyan!50!blue!90!main-text}
    \soluline{#1}\nobreakspace\nobreakspace
    \let\qedsymbol\customqedsymbol
  }{\pushQED{\qed}\popQED\par}

%%================================
%%  Configuration of the theorems
%%================================

\newcounter{homework}
\SetTheorem{problem,question}{shared counter=homework}
\SetTheorem{lemma,theorem,proposition,fact,remark}{number within=homework}

\endinput
%%
%% End of file `homework.cls'.
