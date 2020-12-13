# Takes a POEditor .po file and an Unreal Engine .po file and overwrites the
# latter with translated strings from the former, matching msgctxt with
# msgid.
import os
import pycountry

localization_path = '../Content/Localization/Game/'
poeditor_path = '../Content/Localization/POEditor/'

poeditor_files = os.listdir(poeditor_path)

for poe_file in poeditor_files:
    file_name = poe_file[17:-3]
    file_split = file_name.split("_")
    language_name = file_split[0]
    if len(file_split) > 1:
        variant_name = file_split[1]
        # No need to translate English US
        if 'English' in poe_file and 'US' in variant_name:
            continue
        if 'UK' in variant_name:
            variant_name = 'GB'
        elif 'simplified' in variant_name:
            variant_name = 'Hans'
        elif 'traditional' in variant_name:
            variant_name = 'Hant'
        elif 'Moldavian' in language_name:
            language_name = 'Romanian'
            variant_name = 'MD'
        print(language_name + " ({0})".format(variant_name))
        variant_name = "-" + variant_name
    else:
        variant_name = ""
        print(language_name)

    if 'Greek' in language_name:
        language_code = 'el'
    else:
        pycountry_language = pycountry.languages.get(name=language_name)
        try:
            language_code = pycountry_language.alpha_2
        except AttributeError:
            print("Skipping {language_name} because pycountry couldn't "
                  "get a language code.".format(language_name=language_name))
            continue

    ue_file = localization_path + language_code + variant_name + "/Game.po"
    if not os.path.exists(ue_file):
        print("Skipping {language_name} because a UE .po file "
              "couldn't be found.".format(language_name=language_name))
        continue

    # We could probably do something clever like load this file into
    # a msgid:msgstr dictionary instead of indexing a list
    with open(poeditor_path + poe_file, 'r', encoding='utf-8') as poeditor_file:
        poeditor_lines = poeditor_file.read().split('\n')

    with open(ue_file, 'r', encoding='utf-8') as game_file:
        output_text = []

        last_msgctxt = None
        for line in game_file:
            # Save the latest msgctxt (msgid) for use in a valid msgstr
            if line.startswith("msgctxt"):
                last_msgctxt = line.split("\"")[1]

            # Make sure we've encountered a last_msgctxt yet.
            if line.startswith("msgstr") and last_msgctxt:

                # Ignore empty msgctxt
                if last_msgctxt:

                    # UE uses , whereas POEditor msgids use . sometimes
                    msgid = "msgid \"{msgctxt}\""
                    this_msgid = msgid.format(msgctxt=last_msgctxt)

                    # Is this string in the POEditor file?
                    try:
                        poeditor_id_location = poeditor_lines.index(this_msgid)
                    except ValueError:
                        try:
                            this_msgid = msgid.format(msgctxt=last_msgctxt.replace(",", ".", 1))
                            poeditor_id_location = poeditor_lines.index(this_msgid)
                        except:
                            output_text.append(line)
                            continue

                    # msgstr comes right after msgid
                    msgstr = poeditor_lines[poeditor_id_location+1]

                    output_text.append(msgstr + "\n")
            else:
                output_text.append(line)

    # Write out to file
    with open(ue_file, 'w', encoding='utf-8') as output_file:
        for output_line in output_text:
            output_file.write(output_line)
