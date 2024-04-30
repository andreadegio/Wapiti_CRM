<template>
    <v-app>
        <v-app-bar app>
            <h1 class="text-center">Corso</h1>
        </v-app-bar>
        <v-main>

            <v-row>
                <v-col cols="9" style="background-color: blue; height: 100%;">
                    <v-row style="background-color: red; display: flex;  padding: 1rem;"> Video

                    </v-row>
                    <v-row style="background-color: green;  padding: 1rem;">Descrizione

                    </v-row>
                </v-col>

                <v-col cols="3" id="sidebar-corso">Elenco

                </v-col>
            </v-row>


        </v-main>
    </v-app>

</template>
<script>

</script>
<style scoped>
#sidebar-corso {
    background-color: brown;
    padding: 1rem;
    overflow: auto;
    position: fixed;
    height: 100%;
    z-index: 1;
    right: 0;
}
</style>
