(:
XML Query Use Cases: http://www.w3.org/TR/xquery-use-cases/
Copyright ©2003 World Wide Web Consortium, (Massachusetts Institute of Technology, European Research Consortium for Informatics and Mathematics, Keio University). All Rights Reserved. This work is distributed under the W3C® Software License [1] in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
[1] http://www.w3.org/Consortium/Legal/2002/copyright-software-20021231
:)
(:
 Filename: xmpQ2.xq  
 Source:    http://www.w3.org/TR/xquery-use-cases/#xmp-queries-results-q2  
 Section:   1.1.9.2 Q2  
 Purpose:  Create a flat list of all the title-author pairs, with each pair enclosed in a "result" element. 
 :)

<results>
  {
    for $b in doc("bib.xml")/bib/book,
        $t in $b/title,
        $a in $b/author
    return
        <result>
            { $t }    
            { $a }
        </result>
  }
</results>

