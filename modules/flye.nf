process flye {
    label 'flye'
    publishDir "${params.output}/${name}/assembly/", mode: 'copy', pattern: "${name}_raw_flye.fasta"
    publishDir "${params.output}/${name}/assembly/", mode: 'copy', pattern: "flye.log"
    
    input:
    tuple val(name), file(ont), file(genome_size)
    
    output:
    tuple val(name), file(ont), file("${name}_raw_flye.fasta")
    tuple val(name), file("flye.log")
    
    shell:
    """
    size=\$(cat !{genome_size})
    flye --nano-raw !{ont} -o flye_output -t !{task.cpus} --plasmids --meta --genome-size \$size
    mv flye_output/assembly.fasta ${name}_raw_flye.fasta
    mv flye_output/flye.log flye.log
    """

}