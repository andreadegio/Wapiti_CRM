<template>
    <div>
        <h1 class="text-center">Corso</h1>
        <v-app>
            <v-container fluid grid-list-md >
                <v-layout row wrap align-start justify-space-around fill-height>
                    <!-- Sezione Dati Generali -->
                    <v-flex xs12 sm6 md4 lg3 xl2 order-xs5 order-sm7 order-md5 order-lg4>
                        <datigenerali :corso='corso'></datigenerali>
                    </v-flex>
                    
                    <!-- Sezione Descrizione e Modalità-->
                    <v-flex xs12 sm10 offset-sm1 >
                        <descrizionimodalita :corso='corso'></descrizionimodalita>
                    </v-flex>
                    
                </v-layout>
            </v-container>
        </v-app>
    </div>
</template>