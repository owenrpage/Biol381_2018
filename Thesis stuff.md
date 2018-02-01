**Note**: all of these were done in Typora using mermaid. Soon I will be converting these and developing them 

**Figure 1**:A model of allergen-induced asthma that was proposed by my lab in a paper

```mermaid
graph LR
A(HDM) --> B(IL1B)
C(PSSG/ PKM2-SSG)
D(Glycolysis)
E(Lactate)
F(Chronic airways inflammation and remodeling)
B --> C
C-->|GSTP| D
D--> E
E--> F
H{GLRX}
I{P-SH/ PKM-2-SH}
H--> D
D--> I
```












**Figure 2**: Model of feedback loop via redox biology resulting in emerging airway disease- a slightly more involved working model that I am working on. I did this model before finding the one above so it is be no means complete and is most definitely a work in progress. It is focused on showing the feedback loop that is present.


```mermaid
graph LR
A((ROS))--> |GSTPI-induced S-glutathionylation| B[PKMII to SSGSSG-PKMII]
	C[increased Glycolysis]
	D((EMT, tissue remodeling, and </br> emerging airway disease))
	G[HDM]
	H[TH2 immune response]
    B -->|more production of lactate| C
    C --> |more H+ due to ETS Complex IV|A 
    D--> A
    G--> H
    H --> A
    C -->H
    H--> D
```







**Figure 3**: Early proposed addition to model: the significance of JNK1.


```mermaid
graph LR
A((ROS))--> |GSTPI-induced S-glutathionylation| B[PKMII to SSGSSG-PKMII]
	C[increased Glycolysis]
	D((EMT, tissue remodeling, and </br> emerging airway disease))
	E{JNK1 to pJNK1}
	F[STAT6 to pSTAT6]
	G[HDM]
	H[TH2 immune response]
	I[IL-13 recruitment]
	J[cytokine recruitment]
	K(Epithelial to Mesenchymal Shift)
    B -->|more production of lactate| C
    C --> |more H+ due to ETS Complex IV|A 
    B -->E
    D--> A
    E--> D
    D--> I
    I --> F
    G--> H
    H--> I 
    H--> J
    I --> A
    J --> A
    E--> J
    E --> I
    F --> D
    
 
```



