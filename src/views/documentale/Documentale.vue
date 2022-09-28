<template>
  <CContainer
    id="doc"
    class="min-vh-100 pt-2"
    style="
      background: rgb(255, 255, 255) url('img/filigrana.jpg') no-repeat scroll
        0% 0%;
    "
  >
    <div>
      <CRow class="pl-3 mt-2" style="justify-content: center">
        <!-- <h1 class="mb-3 titolo_sezione">Documentale</h1> -->
      </CRow>
      <VisualizzaDocumento />

      <CRow id="RowExplorer" class="min-vh-100">
        <!-- colonna file manager -->
        <CCol class="file_manager" md="3">
          <!-- Intermediari Emittenti e Proponenti -->

          <div
            v-for="folder in intermediari_list"
            :key="folder.slug"
            class="folder parent pt-0 pl-2"
          >
            <div
              class="py-1"
              style="border-bottom: 1px solid lightgray"
              v-if="folder.visible == 'admin' && admin"
            >
              <span
                @click="
                  call_folder_list(folder);
                  dove_sono = folder.slug;
                  color = 'white';
                "
                style="white-space: nowrap"
                class="icon_folder h4"
                :class="{ highlight: dove_sono == folder.slug }"
              >
                {{ folder.nome }}</span
              >
            </div>
            <div
              class="py-1"
              style="border-bottom: 1px solid lightgray"
              v-if="folder.visible == 'all'"
            >
              <span
                @click="
                  call_folder_list(folder);
                  dove_sono = folder.slug;
                  color = 'white';
                "
                style="white-space: nowrap"
                class="icon_folder h4"
                :class="{ highlight: dove_sono == folder.slug }"
              >
                {{ folder.nome }}</span
              >
            </div>
          </div>
          <!-- Documenti Broker -->
          <div v-if="!admin">
            <div
              v-for="folder in documenti_list"
              :key="folder.slug"
              class="folder parent pt-0 pl-2 py-1"
              style="border-bottom: 1px solid lightgray"
            >
              <span
                @click="
                  call_folder_list(folder);
                  dove_sono = folder.slug;
                  color = '';
                "
                style="white-space: nowrap"
                class="icon_folder h4"
                :class="{ highlight: dove_sono == folder.slug }"
              >
                {{ folder.nome }}</span
              >
              <li
                v-for="items in folder.childs"
                :key="items.slug"
                class="folder h5 pl-3"
              >
                └
                <span
                  @click="
                    call_subfolder_list(items, folder);
                    dove_sono = items.slug;
                  "
                  class="icon_folder"
                  :class="{ highlight: dove_sono == items.slug }"
                  style="white-space: nowrap"
                  >{{ items.nome }}</span
                >
              </li>
            </div>
          </div>
          <!-- Settori -->
          <div
            v-for="folder in folder_list"
            :key="folder.slug"
            class="folder parent pt-0 pl-2 py-1"
            style="border-bottom: 1px solid lightgray"
          >
            <span
              @click="
                call_folder_list(folder);
                dove_sono = folder.slug;
                color = '';
              "
              style="white-space: nowrap"
              class="icon_folder h4"
              :class="{ highlight: dove_sono == folder.slug }"
            >
              {{ folder.nome }}</span
            >
            <li
              v-for="items in folder.childs"
              :key="items.slug"
              class="folder h5 pl-3"
            >
              └
              <span
                @click="
                  call_subfolder_list(items, folder);
                  dove_sono = items.slug;
                "
                class="icon_folder"
                :class="{ highlight: dove_sono == items.slug }"
                style="white-space: nowrap"
                >{{ items.nome }}</span
              >
              <div class="pl-4" v-show="items.slug == 'ALTRE_GARANZIE'">
                <li
                  v-for="tipo in altre_gar"
                  :key="tipo.index"
                  class="folder h6 pl-3"
                >
                  └
                  <span
                    class="icon_folder"
                    style="white-space: nowrap"
                    @click="
                      filter_garanzie(tipo);
                      dove_sono = tipo;
                    "
                    :class="{ highlight: dove_sono == tipo }"
                    >{{ tipo }}</span
                  >
                </li>
              </div>
              <div class="pl-4" v-show="items.slug == 'ALTRI_SERVIZI'">
                <li
                  v-for="tipo in altri_servizi"
                  :key="tipo.index"
                  class="folder h6"
                >
                  └
                  <span
                    class="icon_folder"
                    style="white-space: nowrap"
                    @click="
                      filter_servizi(tipo);
                      dove_sono = tipo;
                    "
                    :class="{ highlight: dove_sono == tipo }"
                    >{{ tipo }}</span
                  >
                </li>
              </div>
            </li>
          </div>
        </CCol>

        <!-- colonna centrale elenco file browser -->
        <CCol md="9" :style="{ 'background-color': color }">
          <div>
            <!-- breadcrumbs -->
            <div v-if="breadcrumbs.length > 0" id="breadcrumbs" class="pt-3">
              <span style="border: 1px solid; border-radius: 3px; padding: 2px">
                <font-awesome-icon
                  :icon="breadcrumbs[0][1]"
                ></font-awesome-icon>
                {{ breadcrumbs[0][0] }}
              </span>
              <span v-if="breadcrumbs.length >= 2" style="padding: 2px"
                ><i class="fas fa-chevron-right"></i
              ></span>
              <span
                v-if="breadcrumbs.length >= 2"
                style="border: 1px solid; border-radius: 3px; padding: 2px"
                >{{ breadcrumbs[1][0] }}</span
              >
              <span v-if="breadcrumbs.length == 3" style="padding: 2px"
                ><i class="fas fa-chevron-right"></i
              ></span>
              <span
                v-if="breadcrumbs.length == 3"
                style="border: 1px solid; border-radius: 3px; padding: 2px"
                >{{ breadcrumbs[2][0] }}</span
              >
              <div class="pt-5" v-if="settore == 'DOCUMENTI'">
                <span>
                  <div
                    v-for="folder in documenti_list"
                    :key="folder.name"
                    class="pt-0"
                  >
                    <div v-show="folder.subFolder">
                      <table
                        class="table table-striped table-bordered table-hover"
                        style="border: 0 !important"
                      >
                        <thead>
                          <tr>
                            <th
                              style="
                                border-left: 0 !important;
                                border-right: 0 !important;
                              "
                              class="text-center"
                            >
                              Seleziona una cartella
                            </th>
                            <th
                              style="
                                border-left: 0 !important;
                                border-right: 0 !important;
                              "
                            ></th>
                          </tr>
                        </thead>
                        <tbody>
                          <tr
                            v-for="items in folder.childs"
                            :key="items.nome"
                            @click="
                              call_subfolder_list(items, folder);
                              dove_sono = items.slug;
                            "
                            style="cursor: pointer"
                          >
                            <td
                              style="
                                border-left: 0 !important;
                                border-right: 0 !important;
                              "
                            >
                              <span class="icon_folder pr-2"></span
                              >{{ items.nome }}
                            </td>

                            <td
                              class="text-right"
                              style="
                                border-left: 0 !important;
                                border-right: 0 !important;
                              "
                            ></td>
                          </tr>
                        </tbody>
                      </table>
                    </div>
                  </div>
                </span>
              </div>
              <!-- SETTORI 1 E 2 -->
              <div class="pt-5" v-if="settore == 'SETTORI 1 E 2'">
                <span>
                  <div
                    v-for="folder in folder_list"
                    :key="folder.name"
                    class="pt-0"
                  >
                    <div v-show="folder.subFolder">
                      <table
                        class="table table-striped table-bordered table-hover"
                        style="border: 0 !important"
                      >
                        <thead>
                          <tr>
                            <th
                              style="
                                border-left: 0 !important;
                                border-right: 0 !important;
                              "
                              class="text-center"
                            >
                              Seleziona una cartella
                            </th>
                            <th
                              style="
                                border-left: 0 !important;
                                border-right: 0 !important;
                              "
                            ></th>
                          </tr>
                        </thead>
                        <tbody>
                          <tr
                            v-for="items in folder.childs"
                            :key="items.nome"
                            @click="
                              call_subfolder_list(items, folder);
                              dove_sono = items.slug;
                            "
                            style="cursor: pointer"
                          >
                            <td
                              style="
                                border-left: 0 !important;
                                border-right: 0 !important;
                              "
                            >
                              <span class="icon_folder pr-2"></span
                              >{{ items.nome }}
                            </td>

                            <td
                              class="text-right"
                              style="
                                border-left: 0 !important;
                                border-right: 0 !important;
                              "
                            ></td>
                          </tr>
                        </tbody>
                      </table>
                    </div>
                  </div>
                </span>
              </div>
            </div>
            <div v-else class="pt-5 display-4">
              <font-awesome-icon icon="arrow-left"></font-awesome-icon> Effettua
              una selezione
            </div>
            <div v-show="vuoto" class="pt-5 h4 text-center">
              - Al momento non ci sono documenti disponibili -
            </div>
            <!-- DATA TABLE PER ORGANIGRAMMA ABY -->
            <div class="pt-5" v-if="settore === 'ORGANIGRAMMA ABY BROKER'">
              <CDataTable
                id="int_table"
                ref="tabella_ORGANIGRAMMA ABY"
                :items="files"
                :fields="fields_ORGANIGRAMMA"
                sorter
                hover
                border
                :itemsPerPage="20"
                pagination
                :table-filter="{
                  placeholder: 'Ricerca...',
                  label: 'Ricerca:',
                }"
                striped
                :items-per-page-select="{ label: 'Risultati per pagina' }"
                :noItemsView="{ noItems: ' ' }"
              >
                <template #Download="{ item }">
                  <td class="text-center">
                    <a
                      :href="item.Nomefile"
                      @click.prevent="
                        preview(item.Nomefile, 'ORGANIGRAMMA');
                        titoloModale(dove_sono, item.Descrizione);
                      "
                    >
                      <i class="fas fa-download fa-2x"></i
                    ></a>
                  </td>
                </template>
              </CDataTable>
            </div>
            <!-- DATA TABLE PER CIRCOLARI -->
            <div
              class="pt-5"
              v-if="
                (settore === 'CIRCOLARI INTERNE' && vuoto == false) ||
                (settore === 'CIRCOLARI OPERATIVE' && vuoto == false)
              "
            >
              <CDataTable
                id="int_table"
                ref="tabella_CIRCOLARI"
                :items="files"
                :fields="fields_CIRCOLARI"
                sorter
                hover
                border
                :itemsPerPage="20"
                pagination
                :table-filter="{
                  placeholder: 'Ricerca...',
                  label: 'Ricerca:',
                }"
                striped
                :items-per-page-select="{ label: 'Risultati per pagina' }"
                :noItemsView="{ noItems: ' ' }"
              >
                <template #Download="{ item }">
                  <td class="text-center">
                    <a
                      :href="item.Filepath + '/' + item.Filename"
                      @click.prevent="
                        preview(item.Filepath + '/' + item.Filename)
                      "
                    >
                      <i class="fas fa-download fa-2x"></i
                    ></a>
                  </td>
                </template>
              </CDataTable>
            </div>
            <!-- DATA TABLE PER DOCUMENTI INTERMEDIARIO -->
            <div
              class="pt-5"
              v-if="
                settore === 'INTERMEDIARIO' ||
                (settore === 'PRECONTRATTUALE' && vuoto == false)
              "
            >
              <CDataTable
                id="int_table"
                ref="tabella_doc"
                :items="files"
                :fields="fields_DOCUMENTI"
                hover
                border
                striped
                :noItemsView="{ noItems: ' ' }"
              >
                <template #visualizza="{ item }">
                  <td class="py-2 text-center">
                    <CButton
                      v-if="item.Nomefile !== ''"
                      color="primary"
                      variant="outline"
                      square
                      size="sm"
                      @click="
                        preview(item.Nomefile, 'INTERMEDIARIO');
                        titoloModale(dove_sono, item.Descrizione);
                      "
                    >
                      Visualizza
                    </CButton>
                  </td>
                </template>
              </CDataTable>
            </div>
            <!-- DATA TABLE PER EMITTENTI -->
            <div class="pt-3" v-if="settore === 'INTERMEDIARI EMITTENTI'">
              <div class="row">
                <div class="col-sm-4"></div>
                <div class="col-sm-4 text-center"></div>
                <div class="col-sm-4 text-right">
                  Totale Intermediari Emittenti: <b>{{ files.length }}</b>
                </div>
              </div>
              <CDataTable
                id="emittenti_table"
                :items="files"
                :fields="
                  admin
                    ? fields_INTERMEDIARI_EMITTENTI_ADMIN
                    : fields_INTERMEDIARI_EMITTENTI
                "
                ref="tabella_doc"
                sorter
                hover
                border
                :itemsPerPage="20"
                pagination
                :table-filter="{
                  placeholder: 'Ricerca...',
                  label: 'Ricerca:',
                }"
                striped
                :items-per-page-select="{ label: 'Risultati per pagina' }"
                :noItemsView="{ noItems: ' ' }"
              >
                <template #RUI="{ item }">
                  <td class="text-center">{{ item.RUI }}</td>
                </template>
                <template #Quanti_prodotti_in_uso="{ item }">
                  <td class="text-center">
                    <router-link
                      :to="{
                        name: 'DettagliIntermediario',
                        params: {
                          intermediario: item,
                          elenco: files,
                        },
                      }"
                    >
                      <CButton
                        size="sm"
                        color="primary"
                        variant="outline"
                        v-c-tooltip="
                          'Clicca per visualizzare i Prodotti in uso'
                        "
                      >
                        {{ item.Quanti_prodotti_in_uso }}
                        {{
                          item.Quanti_prodotti_in_uso == 1
                            ? "prodotto"
                            : "prodotti"
                        }}
                        in uso
                      </CButton>
                    </router-link>
                  </td>
                </template>
                <template #POG="{ item }">
                  <td class="py-2 text-center">
                    <CButton
                      v-if="item.POG !== ''"
                      color="primary"
                      variant="outline"
                      square
                      size="sm"
                      @click="
                        preview(item.POG, 'INTERMEDIARIO');
                        titoloModale('EMITTENTE', item.Descrizione, 'POG');
                      "
                    >
                      Visualizza
                    </CButton>
                  </td>
                </template>

                <template #RilieviDiAby="{ item }">
                  <td class="py-2 text-center">
                    <router-link
                      :to="{
                        name: 'Rilievi_Audit',
                        params: {
                          intermediario: item,
                          oldData: files,
                          origine: 'Emittenti',
                          richiesta: 'Aby',
                        },
                      }"
                    >
                      <CButton size="sm" color="primary" variant="outline">
                        Mostra
                      </CButton>
                    </router-link>
                  </td>
                </template>
                <template #RilieviIntermediari="{ item }">
                  <td class="py-2 text-center">
                    <router-link
                      :to="{
                        name: 'Rilievi_Audit',
                        params: {
                          intermediario: item,
                          oldData: files,
                          origine: 'Emittenti',
                          richiesta: 'Int',
                        },
                      }"
                    >
                      <CButton size="sm" color="primary" variant="outline">
                        Mostra
                      </CButton>
                    </router-link>
                  </td>
                </template>
                <template #Audit="{ item }">
                  <td class="py-2 text-center">
                    <router-link
                      :to="{
                        name: 'Rilievi_Audit',
                        params: {
                          intermediario: item,
                          oldData: files,
                          origine: 'Emittenti',
                          richiesta: 'Aud',
                        },
                      }"
                    >
                      <CButton size="sm" color="primary" variant="outline">
                        Mostra
                      </CButton>
                    </router-link>
                  </td>
                </template>
              </CDataTable>
            </div>
            <!-- DATA TABLE PER PROPONENTI -->
            <div class="pt-1" v-if="settore === 'INTERMEDIARI PROPONENTI'">
              <p class="text-right">
                Totale Intermediari Proponenti: <b>{{ files.length }}</b>
              </p>
              <CDataTable
                id="proponenti_table"
                :items="files"
                :fields="fields_INTERMEDIARI_PROPONENTI"
                ref="tabella_doc"
                sorter
                hover
                border
                :itemsPerPage="20"
                pagination
                :table-filter="{
                  placeholder: 'Ricerca...',
                  label: 'Ricerca:',
                }"
                striped
                :items-per-page-select="{ label: 'Risultati per pagina' }"
                :noItemsView="{ noItems: ' ' }"
              >
                <template #RUI="{ item }">
                  <td class="text-center">{{ item.RUI }}</td>
                </template>
                <template #Quante_unita_operative_attive="{ item }">
                  <td class="text-center">
                    <router-link
                      :to="{
                        name: 'DettagliProponente',
                        params: {
                          intermediario: item,
                          proponenti: files,
                        },
                      }"
                    >
                      <CButton
                        size="sm"
                        color="primary"
                        variant="outline"
                        v-c-tooltip="
                          'Clicca per visualizzare le unità operative'
                        "
                      >
                        {{ item.Quante_unita_operative_attive }}
                        {{
                          item.Quante_unita_operative_attive == 1
                            ? "Unità operativa"
                            : "Unità operative"
                        }}
                      </CButton>
                    </router-link>
                  </td>
                </template>
                <template #POG="{ item }">
                  <td class="py-2 text-center">
                    <CButton
                      v-if="item.POG !== ''"
                      color="primary"
                      variant="outline"
                      square
                      size="sm"
                      @click="
                        preview(item.POG, 'INTERMEDIARIO');
                        titoloModale('PROPONENTE', item.Descrizione, 'POG');
                      "
                    >
                      Visualizza
                    </CButton>
                  </td>
                </template>
                <template #RilieviDiAby="{ item }">
                  <td class="py-2 text-center">
                    <router-link
                      :to="{
                        name: 'Rilievi_Audit',
                        params: {
                          intermediario: item,
                          oldData: files,
                          origine: 'Proponenti',
                          richiesta: 'Aby',
                        },
                      }"
                    >
                      <CButton size="sm" color="primary" variant="outline">
                        Mostra
                      </CButton>
                    </router-link>
                  </td>
                </template>
                <template #RilieviIntermediari="{ item }">
                  <td class="py-2 text-center">
                    <router-link
                      :to="{
                        name: 'Rilievi_Audit',
                        params: {
                          intermediario: item,
                          oldData: files,
                          origine: 'Proponenti',
                          richiesta: 'Int',
                        },
                      }"
                    >
                      <CButton size="sm" color="primary" variant="outline">
                        Mostra
                      </CButton>
                    </router-link>
                  </td>
                </template>
                <template #Audit="{ item }">
                  <td class="py-2 text-center">
                    <router-link
                      :to="{
                        name: 'Rilievi_Audit',
                        params: {
                          intermediario: item,
                          oldData: files,
                          origine: 'Proponenti',
                          richiesta: 'Aud',
                        },
                      }"
                    >
                      <CButton size="sm" color="primary" variant="outline">
                        Mostra
                      </CButton>
                    </router-link>
                  </td>
                </template>
              </CDataTable>
            </div>
            <!-- DATA TABLE PER UNITA' OPERATIVE -->
            <div class="pt-1" v-if="settore === 'UNITA OPERATIVE'">
              <p class="text-right">
                Totale Unità Operative: <b>{{ files.length }}</b>
              </p>
              <CDataTable
                id="UO_table"
                :items="files"
                :fields="fields_UO"
                ref="tabella_doc"
                sorter
                hover
                border
                :itemsPerPage="20"
                pagination
                :table-filter="{
                  placeholder: 'Ricerca...',
                  label: 'Ricerca:',
                }"
                striped
                :items-per-page-select="{ label: 'Risultati per pagina' }"
                :noItemsView="{ noItems: ' ' }"
              >
                <template #RUI="{ item }">
                  <td class="text-center">{{ item.RUI }}</td>
                </template>
                <template #RilieviDiAby="{ item }">
                  <td class="py-2 text-center">
                    <router-link
                      :to="{
                        name: 'Rilievi_Audit',
                        params: {
                          intermediario: item,
                          oldData: files,
                          origine: 'UO',
                          richiesta: 'Aby',
                        },
                      }"
                    >
                      <CButton size="sm" color="primary" variant="outline">
                        Mostra
                      </CButton>
                    </router-link>
                  </td>
                </template>
                <template #RilieviIntermediari="{ item }">
                  <td class="py-2 text-center">
                    <router-link
                      :to="{
                        name: 'Rilievi_Audit',
                        params: {
                          intermediario: item,
                          oldData: files,
                          origine: 'UO',
                          richiesta: 'Int',
                        },
                      }"
                    >
                      <CButton size="sm" color="primary" variant="outline">
                        Mostra
                      </CButton>
                    </router-link>
                  </td>
                </template>
                <template #Audit="{ item }">
                  <td class="py-2 text-center">
                    <router-link
                      :to="{
                        name: 'Rilievi_Audit',
                        params: {
                          intermediario: item,
                          oldData: files,
                          origine: 'UO',
                          richiesta: 'Aud',
                        },
                      }"
                    >
                      <CButton size="sm" color="primary" variant="outline">
                        Mostra
                      </CButton>
                    </router-link>
                  </td>
                </template>
              </CDataTable>
            </div>
            <!-- DATA TABLE PER RCA -->
            <div class="pt-5" v-if="settore === 'RC AUTO'">
              <CDataTable
                id="rc_table"
                :items="files"
                :fields="fields_RCA"
                ref="tabella_doc"
                sorter
                hover
                border
                pagination
                :table-filter="{
                  placeholder: 'Ricerca...',
                  label: 'Ricerca:',
                }"
                striped
                :items-per-page-select="{ label: 'Risultati per pagina' }"
                :noItemsView="{ noItems: ' ' }"
              >
                <template #visualizza_POG="{ item }">
                  <td class="py-2 text-center">
                    <CButton
                      v-if="item.Pog !== ''"
                      color="primary"
                      variant="outline"
                      square
                      size="sm"
                      @click="
                        preview(item.Pog, 'RCA');
                        titoloModale('RC AUTO', item.Descrizione, 'POG');
                      "
                    >
                      Visualizza
                    </CButton>
                  </td>
                </template>
                <template #visualizza="{ item }">
                  <td class="py-2 text-center">
                    <CButton
                      v-if="item.Nomefile !== ''"
                      color="primary"
                      variant="outline"
                      square
                      size="sm"
                      @click="
                        preview(item.Nomefile, 'RCA');
                        titoloModale(
                          'RC AUTO',
                          item.Descrizione,
                          'SET INFORMATIVO'
                        );
                      "
                    >
                      Visualizza
                    </CButton>
                  </td>
                </template>
              </CDataTable>
            </div>
            <!-- DATA TABLE PER SERVIZI NON ASSICURATIVI -->
            <div class="pt-5" v-if="settore === 'SERVIZI NON ASSICURATIVI'">
              <CDataTable
                id="altre_table"
                :items="files"
                ref="tabella_doc"
                :fields="fields_SERVIZI"
                sorter
                hover
                border
                pagination
                :column-filter-value="{ Tipo: filtro_gar }"
                :table-filter="{
                  placeholder: 'Ricerca...',
                  label: 'Ricerca:',
                }"
                striped
                :items-per-page-select="{ label: 'Risultati per pagina' }"
                :noItemsView="{ noItems: ' ' }"
              >
                <template #visualizza="{ item }">
                  <td class="py-2 text-center">
                    <CButton
                      v-if="item.Nomefile !== ''"
                      color="primary"
                      variant="outline"
                      square
                      size="sm"
                      @click="
                        preview(item.Nomefile, 'NON_ASSICURATIVI');
                        titoloModale(
                          item.Tipo,
                          item.Descrizione,
                          'SET INFORMATIVO'
                        );
                      "
                    >
                      Visualizza
                    </CButton>
                  </td>
                </template>
              </CDataTable>
            </div>
            <!-- DATA TABLE PER ALTRE GARANZIE -->
            <div class="pt-5" v-if="settore === 'ALTRE GARANZIE'">
              <CDataTable
                id="altre_table"
                ref="tabella_doc"
                :items="files"
                :fields="fields_ALTRE"
                sorter
                hover
                pagination
                border
                :column-filter-value="{ Tipo: filtro_gar }"
                :table-filter="{
                  placeholder: 'Ricerca...',
                  label: 'Ricerca:',
                }"
                striped
                :items-per-page-select="{ label: 'Risultati per pagina' }"
                :noItemsView="{ noItems: ' ' }"
              >
                <template #visualizza_POG="{ item }">
                  <td class="py-2 text-center">
                    <CButton
                      v-if="item.Pog !== ''"
                      color="primary"
                      variant="outline"
                      square
                      size="sm"
                      @click="
                        preview(item.Pog, 'ALTRE_GARANZIE');
                        titoloModale(item.Tipo, item.Descrizione, 'POG');
                      "
                    >
                      Visualizza
                    </CButton>
                  </td>
                </template>
                <template #visualizza="{ item }">
                  <td class="py-2 text-center">
                    <CButton
                      v-if="item.Nomefile !== ''"
                      color="primary"
                      variant="outline"
                      square
                      size="sm"
                      @click="
                        preview(item.Nomefile, 'ALTRE_GARANZIE');
                        titoloModale(
                          item.Tipo,
                          item.Descrizione,
                          'SET INFORMATIVO'
                        );
                      "
                    >
                      Visualizza
                    </CButton>
                  </td>
                </template>
              </CDataTable>
            </div>
          </div>
        </CCol>
      </CRow>
    </div>
  </CContainer>
</template>
<script>
import axios from "axios";
import { folder_list, documenti_list, intermediari_list } from "./folder";

import VisualizzaDocumento from "../../containers/VisualizzaDocumento";
const fields_CIRCOLARI = [
  {
    key: "Numero_Formatted",
    _style: "font-weight: bold; text-align:center;",
    label: "Numero",
  },
  {
    key: "Titolo",
    _style: "font-weight: bold; text-align:center;",
    label: "Titolo",
  },
  {
    key: "Insert_Date",
    _style: "font-weight: bold; text-align:center;",
    label: "Data creazione",
  },
  {
    key: "Insert_User",
    _style: "text-align:center;",
    label: "Inserito da",
  },
  {
    key: "Update_Date",
    label: "Data aggiornamento",
    _style: "text-align:center;",
  },
  {
    key: "Update_User",
    label: "Aggiornato da",
    _style: "text-align:center;",
  },
  {
    key: "Note",
    label: "Note",
    sorter: false,
    filter: false,
    _style: "text-align: center;",
  },
  {
    key: "Download",
    label: "Download",
    sorter: false,
    filter: false,
    _style: "text-align: center;",
  },
];
const fields_ORGANIGRAMMA = [
  {
    key: "Descrizione",
    _style: "font-weight: bold; text-align:center;",
    label: "Descrizione",
  },
  {
    key: "Download",
    label: "Download",
    sorter: false,
    filter: false,
    _style: "text-align:center;",
  },
];
// NOMI DELLE COLONNE DELLA TABELLA DOCUMENTI INTERMEDIARIO
const fields_DOCUMENTI = [
  {
    key: "Descrizione",
    _style: "font-weight: bold; text-align:center;",
    label: "Descrizione",
  },
  {
    key: "visualizza",
    label: "Fascicolo  Informativo",
    sorter: false,
    filter: false,
    _style: "text-align:center;",
  },
];
// NOMI COLONNE PER GLI INTERMEDIARI EMITTENTI E PROPONENTI
const fields_INTERMEDIARI_EMITTENTI_ADMIN = [
  {
    key: "RagioneSociale",
    _style: "font-weight: bold; text-align:center;",
    label: "Ragione Sociale",
  },
  {
    key: "RUI",
    _style: "font-weight: bold; text-align:center;",
    label: "RUI",
  },
  {
    key: "Quanti_prodotti_in_uso",
    _style: "font-weight: bold; text-align:center;",
    label: "Elenco Prodotti",
  },
  {
    key: "POG",
    label: "POG",
    sorter: false,
    filter: false,
    _style: "text-align:center;",
  },
  {
    key: "RilieviDiAby",
    label: "Rilievi di Aby",
    sorter: false,
    filter: false,
    _style: "text-align:center;",
  },
  {
    key: "RilieviIntermediari",
    label: "Rilievi Intermediari",
    sorter: false,
    filter: false,
    _style: "text-align:center;",
  },
  {
    key: "Audit",
    label: "Audit",
    sorter: false,
    filter: false,
    _style: "text-align:center;",
  },
];
const fields_INTERMEDIARI_EMITTENTI = [
  {
    key: "RagioneSociale",
    _style: "font-weight: bold; text-align:center;",
    label: "Ragione Sociale",
  },
  {
    key: "RUI",
    _style: "font-weight: bold; text-align:center;",
    label: "RUI",
  },
  {
    key: "Quanti_prodotti_in_uso",
    _style: "font-weight: bold; text-align:center;",
    label: "Elenco Prodotti",
  },
  {
    key: "POG",
    label: "POG",
    sorter: false,
    filter: false,
    _style: "text-align:center;",
  },
  {
    key: "RilieviIntermediari",
    label: "Rilievi Intermediari",
    sorter: false,
    filter: false,
    _style: "text-align:center;",
  },
  {
    key: "Audit",
    label: "Audit",
    sorter: false,
    filter: false,
    _style: "text-align:center;",
  },
];
const fields_INTERMEDIARI_PROPONENTI = [
  {
    key: "RagioneSociale",
    _style: "font-weight: bold; text-align:center;",
    label: "Ragione Sociale",
  },
  {
    key: "RUI",
    _style: "font-weight: bold; text-align:center;",
    label: "RUI",
  },
  {
    key: "Quante_unita_operative_attive",
    _style: "font-weight: bold; text-align:center;",
    label: "Unità Operative Attive",
  },
  {
    key: "POG",
    label: "POG",
    sorter: false,
    filter: false,
    _style: "text-align:center;",
  },
  {
    key: "RilieviDiAby",
    label: "Rilievi di Aby",
    sorter: false,
    filter: false,
    _style: "text-align:center;",
  },
  {
    key: "RilieviIntermediari",
    label: "Rilievi Intermediari",
    sorter: false,
    filter: false,
    _style: "text-align:center;",
  },
  {
    key: "Audit",
    label: "Audit",
    sorter: false,
    filter: false,
    _style: "text-align:center;",
  },
];
// NOMI DELLE COLONNE PER DATA TABLE UNITA OPERATIVE
const fields_UO = [
  {
    key: "Descrizione",
    _style: "font-weight: bold; text-align:center;",
    label: "Descrizione",
  },
  {
    key: "RagioneSociale",
    _style: "font-weight: bold; text-align:center;",
    label: "Ragione Sociale",
  },
  {
    key: "RUI",
    _style: "font-weight: bold; text-align:center;",
    label: "RUI",
  },
  {
    key: "RilieviDiAby",
    label: "Rilievi di Aby",
    sorter: false,
    filter: false,
    _style: "text-align:center;",
  },
  {
    key: "RilieviIntermediari",
    label: "Rilievi Intermediario",
    sorter: false,
    filter: false,
    _style: "text-align:center;",
  },
  {
    key: "Audit",
    label: "Audit",
    sorter: false,
    filter: false,
    _style: "text-align:center;",
  },
];
// NOMI DELLE COLONNE DELLA TABELLA PER RCA
const fields_RCA = [
  {
    key: "Descrizione",
    _style: "font-weight: bold; text-align:center;",
    label: "Compagnia",
  },

  {
    key: "visualizza_POG",
    label: "POG",
    sorter: false,
    filter: false,
    _style: "text-align:center;",
  },
  {
    key: "visualizza",
    label: "Set Informativo",
    sorter: false,
    filter: false,
    _style: "text-align:center;",
  },
];
// NOMI DELLE COLONNE DELLA TABELLA PER ALTRE GARANZIE
const fields_ALTRE = [
  {
    key: "Tipo",
    _style: "font-weight: bold; text-align: center;",
    label: "Tipologia",
  },
  {
    key: "Descrizione",
    _style: "font-weight: bold; text-align: center;",
    label: "Compagnia",
  },

  {
    key: "visualizza_POG",
    label: "POG",
    sorter: false,
    filter: false,
    _style: "text-align: center;",
  },
  {
    key: "visualizza",
    label: "Set Informativo",
    sorter: false,
    filter: false,
    _style: "text-align: center;",
  },
];
// NOMI DELLE COLONNE DELLA TABELLA PER ALTRI SERVIZI
const fields_SERVIZI = [
  {
    key: "Tipo",
    _style: "font-weight: bold; text-align: center;",
    label: "Tipologia",
  },
  {
    key: "Descrizione",
    _style: "font-weight: bold; text-align: center;",
    label: "Descrizione",
  },
  {
    key: "visualizza",
    label: "Set Informativo",
    sorter: false,
    filter: false,
    _style: "text-align: center;",
  },
];

export default {
  name: "Documentale",

  components: {
    VisualizzaDocumento,
  },
  data() {
    return {
      warningModal: false,
      admin: JSON.parse(localStorage.getItem("chisono_data")).Is_Sede,
      viewFile: false, // Usato per mostrare la modale con l'antprima del file
      file_name: "", // Usato per passare l'url alla preview
      folder_list, // Albero dei documenti (veicoli->rca->altre garanzie / rami / energia)
      documenti_list, // Documenti intermediario e precontrattuale
      intermediari_list, // Intermediari Emittenti e Proponenti
      vuoto: false, // Usato per controllare il messaggio "Non ci sono documenti"
      settore: "", // utilizzato per assegnare il data table
      subfolder: "", // utilizzato per il breadcrumb delle cartelle di secondo livello
      breadcrumbs: [], // breadcrumbs di navigazione
      timer: 0, // Utilizzato per temporizzare il passaggio dall'apertura di un documento a l'altro
      select: true, // utilizzato per la visualizzazione del file per far partire il loader o meno
      files: [].map((item, id) => {
        return { ...item, id };
      }),
      dove_sono: undefined,
      fields_RCA,
      fields_ALTRE,
      fields_SERVIZI,
      fields_DOCUMENTI,
      fields_INTERMEDIARI_EMITTENTI,
      fields_INTERMEDIARI_EMITTENTI_ADMIN,
      fields_INTERMEDIARI_PROPONENTI,
      fields_UO,
      fields_CIRCOLARI,
      fields_ORGANIGRAMMA,
      // fields_SETTORE12,

      altre_gar: [],
      altri_servizi: [],
      filtro_gar: "",

      // titolo per la modale di anteprima
      tipologia: null,
      descrizione: null,
      tipoFile: null,

      emittenti: [],
      proponenti: [],

      color: "", // colore di sfondo documentale
      array_link: [], // array contenente l'elenco file per ciascuna cartella del documentale

      // test UO
      // files_UO,
    };
  },
  mounted() {
    this.intermediari_list.forEach((item) =>
      this.array_link.push({
        ["SLUG"]: item.slug,
        ["URL"]: item.URL,
        ["FILE"]: [],
      })
    );
    this.documenti_list.forEach((item) =>
      item.childs.forEach((link) =>
        this.array_link.push({
          ["SLUG"]: link.slug,
          ["URL"]: link.URL,
          ["FILE"]: [],
        })
      )
    );
    this.folder_list.forEach((item) =>
      item.childs.forEach((link) =>
        this.array_link.push({
          ["SLUG"]: link.slug,
          ["URL"]: link.URL,
          ["FILE"]: [],
        })
      )
    );
    this.array_link.forEach((item) =>
      this.recupera_documentale(item.SLUG, item.URL)
    );
    // Utilizzato per tornare a visualizzare gli emittenti/proponenti tornando indietro dalla pagina di dettaglio dell'intermediario
    if (this.$route.params.origine == "Emittenti") {
      let origine = {
        nome: "INTERMEDIARI EMITTENTI",
        slug: "INTERMEDIARI EMITTENTI",
        tipo: "folder",
        ico: "edit",
        URL: "Intermediari_Emittenti",
        subFolder: false,
        visible: "all",
      };
      this.settore = origine.slug;
      this.dove_sono = origine.slug;

      this.breadcrumbs = []; // per popolare il Breadcrumbs
      this.breadcrumbs.push([origine.nome, origine.ico]);
      this.files = JSON.parse(localStorage.getItem("elenco_origine"));
      this.color = "white";
    }
    if (this.$route.params.origine == "Proponenti") {
      let origine = {
        nome: "INTERMEDIARI PROPONENTI",
        slug: "INTERMEDIARI PROPONENTI",
        tipo: "folder",
        ico: "edit",
        URL: "Intermediari_Proponenti",
        subFolder: false,
        visible: "admin",
      };
      this.settore = origine.slug;
      this.dove_sono = origine.slug;

      this.breadcrumbs = []; // per popolare il Breadcrumbs
      this.breadcrumbs.push([origine.nome, origine.ico]);
      this.files = JSON.parse(localStorage.getItem("elenco_origine"));
      this.color = "white";
    }
    if (this.$route.params.origine == "UO") {
      let origine = {
        nome: "UNITA OPERATIVE - Sez. E",
        slug: "UNITA OPERATIVE",
        tipo: "folder",
        ico: "store",
        URL: "UnitaOperative_Di_Aby_Broker",
        subFolder: false,
        visible: "admin",
      };
      this.settore = origine.slug;
      this.dove_sono = origine.slug;

      this.breadcrumbs = []; // per popolare il Breadcrumbs
      this.breadcrumbs.push([origine.nome, origine.ico]);
      this.files = JSON.parse(localStorage.getItem("elenco_origine"));
      this.color = "white";
    }
  },
  methods: {
    reset_pagination() {
      // Forzo sempre la visualizzazione della prima pagina del datagrid per poter ripartire
      // dalla prima ogni volta che cambio folder
      if (this.$refs.tabella_doc) {
        // console.log(this.$refs.tabella_doc.page);
        this.$refs.tabella_doc.page = 1;
      }
    },

    call_folder_list(folder) {
      // console.log("colore "+ this.color);
      // Funzione chiamata dalle cartelle di primo livello (documenti intermediario, precontrattuale, ecc)
      //resetto la paginazione
      this.reset_pagination();
      this.vuoto = false; // Inizializzo il messaggio "non ci sono file"

      // Inizializzo le sottocartelle
      this.altre_gar = [];
      this.altri_servizi = [];
      this.filtro_gar = "";

      this.breadcrumbs = []; // per popolare il Breadcrumbs
      this.breadcrumbs.push([folder.nome, folder.ico]);

      this.settore = folder.slug; // Per identificare il data-table
      this.files = []; // array dei risultati
      if (folder.URL) {
        // Chiamo la funzione per recuperare le informazioni dai servizi
        this.load_documentale(folder.slug);
      } else {
        if (folder.subFolder == false) {
          this.vuoto = true;
          // this.color = "";
        }
      }
    },

    call_subfolder_list(subfolder, folder) {
      // Funzione chiamata dalle cartelle di secondo livello (RCA, Altre garanzie, ecc)

      //resetto la paginazione
      this.reset_pagination();
      this.vuoto = false; // Inizializzo il messaggio "non ci sono file"
      this.color = "white";

      // Inizializzo le sottocartelle
      this.altre_gar = [];
      this.altri_servizi = [];
      this.filtro_gar = "";

      this.breadcrumbs = []; // per popolare il Breadcrumbs
      this.breadcrumbs.push([folder.nome, folder.ico]);
      this.breadcrumbs.push([subfolder.nome]);

      this.subfolder = subfolder.slug; // Per identificare il data-table
      // console.log(subfolder.slug);
      // console.log(this.$data.page);
      switch (subfolder.slug) {
        case "INTERMEDIARIO":
          this.files = [];
          this.settore = "INTERMEDIARIO";
          break;
        case "PRECONTRATTUALE":
          this.files = [];
          this.settore = "PRECONTRATTUALE";
          break;
        case "RC_AUTO":
          this.files = [];
          this.settore = "RC AUTO";
          break;
        case "ALTRE_GARANZIE":
          this.files = [];
          this.settore = "ALTRE GARANZIE";
          this.call_garanzie_list("", "AltreGaranzie"); // chiamata per popolare il sotto elenco delle garanzie
          break;
        case "ALTRI_SERVIZI":
          this.settore = "SERVIZI NON ASSICURATIVI";
          this.call_garanzie_list("", "ServiziNonAssicurativi"); // chiamata per popolare il sotto elenco delle garanzie
          break;
      }
      this.files = []; // array dei risultati
      if (subfolder.URL) {
        // Chiamo la funzione per recuperare le informazioni dai servizi
        this.load_documentale(subfolder.slug);
      } else {
        if (subfolder.subFolder == false) {
          this.vuoto = true;
          // this.color = "";
        }
      }
    },

    async call_garanzie_list(filtro = "", target = "") {
      // FUNZIONE PER GENERARE LE SOTTO CARTELLE DI TERZO LIVELLO DI ALTRE GARANZIE E SERVIZI
      //resetto la paginazione
      this.reset_pagination();
      this.select = true;
      this.file_name = "";
      this.filtro_gar = filtro; //utilizzato per filtrare i risultati nel datatable
      var elenco = [];
      var lista_gar = [];
      if (target !== "") {
        var config = {
          method: "post",
          url: this.$custom_json.servizi_broker + "Documentale_" + target,
          headers: {
            userID: localStorage.getItem("userID"),
            anagraficaID: localStorage.getItem("anagraficaID"),
            unitaoperativaID: localStorage.getItem("unitaoperativaID"),
          },
        };
        await axios(config)
          .then(function (response) {
            // console.log(JSON.stringify(response.data));
            elenco = response.data;
            var lookup = {};
            var items = elenco;
            for (var item, i = 0; (item = items[i++]); ) {
              var name = item.Tipo;

              if (!(name in lookup)) {
                lookup[name] = 1;
                lista_gar.push(name);
              }
            }
          })
          .catch(function (error) {
            elenco = [];
            console.log(error);
          });
      }
      switch (target) {
        case "AltreGaranzie":
          this.altre_gar = lista_gar;
          break;
        case "ServiziNonAssicurativi":
          this.altri_servizi = lista_gar;
          break;
        default:
          this.altre_gar = lista_gar;
      }
    },

    async recupera_documentale(SLUG, URL) {
      if (URL) {
        var elenco = [];
        var config = {
          method: "post",
          url: this.$custom_json.servizi_broker + URL,
          headers: {
            userID: localStorage.getItem("userID"),
            anagraficaID: localStorage.getItem("anagraficaID"),
            unitaoperativaID: localStorage.getItem("unitaoperativaID"),
          },
        };
        await axios(config)
          .then(function (response) {
            elenco = response.data;
          })
          .catch(function (error) {
            elenco = [];
            console.log(error);
          });
        for (var i in this.array_link) {
          if (this.array_link[i].SLUG == SLUG) {
            this.array_link[i].FILE = elenco;
            break;
          }
        }
      }
      // console.log(elenco);
      return elenco;
    },
    async load_documentale(target) {
      // console.log(target);
      this.vuoto = false; // Inizializzo in modo da non mostrare il messaggio "nessun documento" in fase di caricamento
      this.color = "white";
      var elenco = [];

      for (var i in this.array_link) {
        if (this.array_link[i].SLUG == target) {
          elenco = this.array_link[i].FILE;
          break;
        }
      }

      this.files = elenco;
      // console.log("trovato");
      if (this.files.length <= 0) {
        this.vuoto = true; // Variabile usata per il messaggio "non ci sono documenti"
        this.color = "";
      }
    },

    filter_garanzie(tipo) {
      this.reset_pagination();
      this.select = true;
      this.breadcrumbs.length == 3
        ? (this.breadcrumbs[2][0] = tipo)
        : this.breadcrumbs.push([tipo]);
      // svuotamento dell'array files necessario per reimpostare la paginazione
      let temp_file = this.files;
      this.files = [];
      this.files = temp_file;
      this.filtro_gar = tipo;
    },

    filter_servizi(tipo) {
      this.reset_pagination();
      // console.log(tipo);
      this.select = true;
      // console.log("settore: "+ this.settore);
      this.breadcrumbs.length == 3
        ? (this.breadcrumbs[2][0] = tipo)
        : this.breadcrumbs.push([tipo]);
      // svuotamento dell'array files necessario per reimpostare la paginazione
      let temp_file = this.files;
      this.files = [];
      this.files = temp_file;
      this.filtro_gar = tipo;
    },

    // CHIAMATA PER LE SOTTOCARTELLE E PER FILTRARE
    call_parent_list(folder_name, filtro = "") {
      this.select = true;
      // this.timer= 0;
      this.filtro_gar = filtro;
      this.breadcrumbs = [];
      this.breadcrumbs.push([folder_name.nome, folder_name.ico]);
      // alert(index);
      this.settore = "";
      this.file_name = "";
      this.files = [];
    },

    // CHIAMATA PER VISUALIZZARE I PDF
    preview(url, dest) {
      var end_point = "";
      switch (dest) {
        case "ORGANIGRAMMA":
          end_point =
            this.$custom_json.servizi_broker +
            this.$custom_json.ep_broker.documentale_DocumentiIntermediario;
          break;
        case "INTERMEDIARIO":
          end_point =
            this.$custom_json.servizi_broker +
            this.$custom_json.ep_broker.documentale_DocumentiIntermediario;
          break;
        case "RCA":
          end_point =
            this.$custom_json.servizi_broker +
            this.$custom_json.ep_broker.documentale_RCA;
          break;
        case "NON_ASSICURATIVI":
          end_point =
            this.$custom_json.servizi_broker +
            this.$custom_json.ep_broker.documentale_ServiziNonAssicurativi;
          break;
        case "ALTRE_GARANZIE":
          end_point =
            this.$custom_json.servizi_broker +
            this.$custom_json.ep_broker.documentale_AltreGaranzie;
          break;
        default:
          end_point =
            this.$custom_json.servizi_broker +
            this.$custom_json.ep_broker.documentale_broker;
      }
      // console.log("chiamo "+ end_point);
      this.viewFile = true;
      if (this.timer == 0) {
        this.select = false;
        this.file_name = end_point + url;
        this.timer = 1;
        setTimeout(() => {
          this.timer = 0;
        }, 8000);
      } else {
        this.file_name = "";
        // console.log("riprovo");
        setTimeout(() => {
          this.preview(url, dest);
        }, 1000);
      }
    },
    titoloModale(tipologia, descrizione, tipoFile) {
      this.tipologia = tipologia;
      this.descrizione = descrizione;
      this.tipoFile = tipoFile;
    },
  },
};
</script>
<style scoped>
.c-body {
  flex-grow: initial !important;
}

.file_manager {
  background-color: white;
  border-right: 1px solid lightgrey;
  /* border-radius: 5px; */
}

#RowExplorer {
  margin: 1rem 3rem 0 3rem;
  height: 80%;
  /* position: absolute; */
  /* width: 99%; */
  background-position: right !important;
  border-radius: 5px;
  background-size: contain !important;
}

.parent {
  padding-top: 3em;
}
.folder {
  cursor: pointer;
  list-style-type: none;
}

.icon_folder::before {
  content: "\f07b";
  font-family: "Font Awesome 5 free";
  color: rgb(252, 198, 3);
  font-size: 2em;
  font-weight: 900;
  padding-right: 5px;
}
.icon_folder:hover::before {
  content: "\f07c";
  font-family: "Font Awesome 5 free";
  color: rgb(252, 198, 3);
  font-size: 2em;
  font-weight: 900;
  padding-right: 5px;
}
.icon_folder.highlight::before {
  content: "\f07c";
  font-family: "Font Awesome 5 free";
  color: rgb(252, 198, 3);
  font-size: 2em;
  font-weight: 900;
  padding-right: 5px;
}
.highlight {
  font-weight: bold;
}
#doc {
  background-size: cover !important;
  background-position: right !important;
  max-width: none !important;
}
</style>