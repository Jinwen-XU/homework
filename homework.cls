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
  {2023/09/29*} {}
  {Document class for writing homework}

\keys_define:nn { homework }
  {
    , logo          .tl_set:N     = \l__homework_logo_name_tl
    , logo          .initial:n    = { }
    , logo-height   .dim_set:N    = \l__homework_logo_height_dim
    , logo~height   .dim_set:N    = \l__homework_logo_height_dim
    , logo height   .dim_set:N    = \l__homework_logo_height_dim

    , formal-title  .bool_set:N   = \l__homework_formal_title_bool
    , formal-title  .initial:n    = { false }
    , formal~title  .bool_set:N   = \l__homework_formal_title_bool
    , formal title  .bool_set:N   = \l__homework_formal_title_bool

    , unknown       .code:n       = {
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
    \PassOptionsToClass { use indent = false } { minimart }
    \LoadClass { minimart }
  }
  {
    \PassOptionsToClass { use indent = false } { einfart }
    \LoadClass { einfart }
  }

\RequirePackage { ProjLib }

%%================================
%%  Print the title
%%================================

\def\@pretitle{}

\NewDocumentCommand \pretitle { m }
  {
    \def\@pretitle{#1}
  }

\renewcommand{\@maketitle}
  {
    \LocallyStopLineNumbers

    % Insert the pretitle
    \noindent{\@pretitle}\par

    \bool_if:NTF \l__homework_formal_title_bool
      {
        \bigskip
        \begin{center}
          \let\footnote\thanks
          {\minimalist_bfseries:\minimalist_scshape:\sffamily\Large\@title}\\\bigskip
          \color{main-text!80!paper}
          {\small\minimalist_scshape:\@author}
          \par\smallskip\vspace{-\parskip}
          {\small\@date}
        \end{center}
        \projlib_author_if_content_empty:nT { \@date } { \medskip }
        \medskip\par
      }
      {
        \vspace{-.5\baselineskip}

        % Insert the main body of the title
        \noindent
        {\textcolor{main-text!27!paper}{\rule{\textwidth}{0.75pt}}}
        \par
        \vspace{-.5\baselineskip}

        \dim_set:Nn \l_tmpa_dim { \pagetotal }

        \begin{flushright}
          \let\footnote\thanks
          {\minimalist_bfseries:\minimalist_sffamily:\@title}\\\medskip
          \color{main-text!80!paper}
          {\small\minimalist_scshape:\@author}
          \par\vspace{-\parskip}\vspace{2pt}
          {\small\@date}
        \end{flushright}
        \vspace{-.5\baselineskip}
        \projlib_author_if_content_empty:nTF { \@date }
          {
            \vspace{-.2\baselineskip}
          }
          {
            \vspace{-.5\baselineskip}
          }
        {\textcolor{main-text!27!paper}{\rule{\textwidth}{0.75pt}}}
        \par

        \dim_set:Nn \l_tmpb_dim { \pagetotal - \l_tmpa_dim }

        % Insert the logo
        \tl_if_empty:NF \l__homework_logo_name_tl
          {
            \dim_compare:nNnT { \l__homework_logo_height_dim } < { 1pt }
              {
                \dim_set:Nn \l__homework_logo_height_dim { .75\l_tmpb_dim }
              }
            \dim_set:Nn \l_tmpa_dim { \l_tmpb_dim + 1.15\baselineskip }
            \vspace { - \l_tmpa_dim }
            \vspace { .5\l_tmpa_dim - .5\l__homework_logo_height_dim }
            \homework_include_logo:nn { \l__homework_logo_height_dim } { \l__homework_logo_name_tl }
            \vspace { .5\l_tmpa_dim - .5\l__homework_logo_height_dim }
          }
      }

    \par
    \ResumeLineNumbers
  }

\cs_new_protected:Nn \homework_include_logo:nn
  % #1 = height
  % #2 = name
  {
    \includegraphics [ height = #1 ] { #2 }
  }

\AddToHook { begindocument/end }
  {
    \maketitle
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
    \if@twoside
      \fancyfoot[RO,LE]{\small\color{main-text!27!paper} \l__homework_page_of_total_tl }
    \else
      \fancyfoot[R]{\small\color{main-text!27!paper} \l__homework_page_of_total_tl }
    \fi
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

\projlib_langauge_define_multilingual_text:Nn \l__homework_answer_tl
  {
    , EN = { Answer }
    , FR = { Réponse }
    , DE = { Antwort }
    , IT = { Risposta }
    , PT = { Resposta }
    , BR = { Resposta }
    , ES = { Respuesta }
    , CN = { 答 }
    , TC = { 答 }
    , JP = { 解答 }
    , RU = { Ответ }
  }

\newcommand\soluline{\bgroup\markoverwith{\rule[-.45ex]{1pt}{.75pt}}\ULon}
\NewDocumentEnvironment { solution } { O{ \l__homework_solution_tl } }
  {
    \par\noindent
    \color{cyan!50!blue!90!main-text}
    \soluline{#1}\nobreakspace\nobreakspace
    \let\qedsymbol\customqedsymbol
  }
  {
    \pushQED{\qed}
    \popQED
    \par
  }

\NewDocumentEnvironment { answer } { O{ \l__homework_answer_tl } }
  {
    \begin{solution}[#1]
  }
  {
    \end{solution}
  }

%%================================
%%  Configuration of the theorems
%%================================

\newcounter { homework }
\SetTheorem { problem, question, exercise } { shared counter = homework }
\SetTheorem { definition, lemma, theorem, proposition, corollary, example, fact, remark, assertion, assumption, claim, conclusion, conjecture, construction, convention, notation, observation, property, recall } { number within = homework }

%%================================
%%  Special cases for the QED
%%================================

\def\noQED{\let\popQED\relax}
\let\noqed\noQED
\def\proofless{\let\qedsymbol\customqedsymbol\let\simpleqedsymbol\customqedsymbol}

\endinput
%%
%% End of file `homework.cls'.
