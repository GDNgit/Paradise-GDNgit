import { createSearch, decodeHtmlEntities } from 'common/string';
import { useBackend, useLocalState } from '../backend';
import {
  Box,
  Button,
  Icon,
  Input,
  LabeledList,
  Section,
  Stack,
  Table,
  Tabs,
} from '../components';
import { Window } from '../layouts';
import { ComplexModal, modalOpen } from './common/ComplexModal';
import { LoginInfo } from './common/LoginInfo';
import { LoginScreen } from './common/LoginScreen';
import { TemporaryNotice } from './common/TemporaryNotice';

const statusStyles = {
  '*Execute*': 'execute',
  '*Arrest*': 'arrest',
  'Incarcerated': 'incarcerated',
  'Parolled': 'parolled',
  'Released': 'released',
  'Demote': 'demote',
  'Search': 'search',
  'Monitor': 'monitor',
};

const doEdit = (context, field) => {
  modalOpen(context, 'edit', {
    field: field.edit,
    value: field.value,
  });
};

export const SecurityRecords = (properties, context) => {
  const { act, data } = useBackend(context);
  const { loginState, currentPage } = data;

  let body;
  if (!loginState.logged_in) {
    return (
      <Window theme="security" width={800} height={800} resizable>
        <Window.Content>
          <LoginScreen />
        </Window.Content>
      </Window>
    );
  } else {
    if (currentPage === 1) {
      body = <SecurityRecordsPageList />;
    } else if (currentPage === 2) {
      body = <SecurityRecordsPageView />;
    }
  }

  return (
    <Window theme="security" width={800} height={800} resizable>
      <ComplexModal />
      <Window.Content>
        <Stack fill vertical>
          <LoginInfo />
          <TemporaryNotice />
          <SecurityRecordsNavigation />
          <Section fill scrollable>
            {body}
          </Section>
        </Stack>
      </Window.Content>
    </Window>
  );
};

const SecurityRecordsNavigation = (properties, context) => {
  const { act, data } = useBackend(context);
  const { currentPage, general } = data;
  return (
    <Stack vertical mb={1}>
      <Stack.Item>
        <Tabs>
          <Tabs.Tab
            icon="list"
            selected={currentPage === 1}
            onClick={() => act('page', { page: 1 })}
          >
            List Records
          </Tabs.Tab>
          {currentPage === 2 && general && !general.empty && (
            <Tabs.Tab icon="file" selected={currentPage === 2}>
              Record: {general.fields[0].value}
            </Tabs.Tab>
          )}
        </Tabs>
      </Stack.Item>
    </Stack>
  );
};

const SecurityRecordsPageList = (properties, context) => {
  const { act, data } = useBackend(context);
  const { records } = data;
  const [searchText, setSearchText] = useLocalState(context, 'searchText', '');
  const [sortId, _setSortId] = useLocalState(context, 'sortId', 'name');
  const [sortOrder, _setSortOrder] = useLocalState(context, 'sortOrder', true);
  return (
    <Stack fill vertical>
      <SecurityRecordsActions />
      <Stack.Item grow>
        <Section>
          <Table className="SecurityRecords__list">
            <Table.Row bold>
              <SortButton id="name">Name</SortButton>
              <SortButton id="id">ID</SortButton>
              <SortButton id="rank">Assignment</SortButton>
              <SortButton id="fingerprint">Fingerprint</SortButton>
              <SortButton id="status">Criminal Status</SortButton>
            </Table.Row>
            {records
              .filter(
                createSearch(searchText, (record) => {
                  return (
                    record.name +
                    '|' +
                    record.id +
                    '|' +
                    record.rank +
                    '|' +
                    record.fingerprint +
                    '|' +
                    record.status
                  );
                })
              )
              .sort((a, b) => {
                const i = sortOrder ? 1 : -1;
                return a[sortId].localeCompare(b[sortId]) * i;
              })
              .map((record) => (
                <Table.Row
                  key={record.id}
                  className={
                    'SecurityRecords__listRow--' + statusStyles[record.status]
                  }
                  onClick={() =>
                    act('view', {
                      uid_gen: record.uid_gen,
                      uid_sec: record.uid_sec,
                    })
                  }
                >
                  <Table.Cell>
                    <Icon name="user" /> {record.name}
                  </Table.Cell>
                  <Table.Cell>{record.id}</Table.Cell>
                  <Table.Cell>{record.rank}</Table.Cell>
                  <Table.Cell>{record.fingerprint}</Table.Cell>
                  <Table.Cell>{record.status}</Table.Cell>
                </Table.Row>
              ))}
          </Table>
        </Section>
      </Stack.Item>
    </Stack>
  );
};

const SortButton = (properties, context) => {
  const [sortId, setSortId] = useLocalState(context, 'sortId', 'name');
  const [sortOrder, setSortOrder] = useLocalState(context, 'sortOrder', true);
  const { id, children } = properties;
  return (
    <Table.Cell>
      <Button
        color={sortId !== id && 'transparent'}
        width="100%"
        onClick={() => {
          if (sortId === id) {
            setSortOrder(!sortOrder);
          } else {
            setSortId(id);
            setSortOrder(true);
          }
        }}
      >
        {children}
        {sortId === id && (
          <Icon name={sortOrder ? 'sort-up' : 'sort-down'} ml="0.25rem;" />
        )}
      </Button>
    </Table.Cell>
  );
};

const SecurityRecordsActions = (properties, context) => {
  const { act, data } = useBackend(context);
  const { isPrinting } = data;
  const [searchText, setSearchText] = useLocalState(context, 'searchText', '');
  return (
    <Stack>
      <Stack.Item>
        <Button
          content="New Record"
          icon="plus"
          onClick={() => act('new_general')}
        />
        <Button
          disabled={isPrinting}
          icon={isPrinting ? 'spinner' : 'print'}
          iconSpin={!!isPrinting}
          content="Print Cell Log"
          ml="0.25rem"
          onClick={() => modalOpen(context, 'print_cell_log')}
        />
      </Stack.Item>
      <Stack.Item grow>
        <Input
          placeholder="Search by Name, ID, Assignment, Fingerprint, Status"
          width="100%"
          onInput={(e, value) => setSearchText(value)}
        />
      </Stack.Item>
    </Stack>
  );
};

const SecurityRecordsPageView = (properties, context) => {
  const { act, data } = useBackend(context);
  const { isPrinting, general, security } = data;
  if (!general || !general.fields) {
    return <Box color="bad">General records lost!</Box>;
  }
  return (
    <Stack fill vertical>
      <Stack.Item>
        <Section
          title="General Data"
          buttons={
            <>
              <Button
                disabled={isPrinting}
                icon={isPrinting ? 'spinner' : 'print'}
                iconSpin={!!isPrinting}
                content="Print Record"
                onClick={() => act('print_record')}
              />
              <Button.Confirm
                icon="trash"
                tooltip={
                  'WARNING: This will also delete the Security ' +
                  'and Medical records associated to this crew member!'
                }
                tooltipPosition="bottom-start"
                content="Delete Record"
                onClick={() => act('delete_general')}
              />
            </>
          }
        >
          <SecurityRecordsViewGeneral />
        </Section>
      </Stack.Item>
      <Stack.Item>
        <Section
          title="Security Data"
          buttons={
            <Button.Confirm
              icon="trash"
              disabled={security.empty}
              content="Delete Record"
              onClick={() => act('delete_security')}
            />
          }
        >
          <SecurityRecordsViewSecurity />
        </Section>
      </Stack.Item>
    </Stack>
  );
};

const SecurityRecordsViewGeneral = (_properties, context) => {
  const { data } = useBackend(context);
  const { general } = data;
  if (!general || !general.fields) {
    return <Box color="bad">General records lost!</Box>;
  }
  return (
    <>
      <Box float="left">
        <LabeledList>
          {general.fields.map((field, i) => (
            <LabeledList.Item key={i} label={field.field} prewrap>
              {decodeHtmlEntities('' + field.value)}
              {!!field.edit && (
                <Button
                  icon="pen"
                  ml="0.5rem"
                  mb={field.line_break ? '1rem' : 'initial'}
                  onClick={() => doEdit(context, field)}
                />
              )}
            </LabeledList.Item>
          ))}
        </LabeledList>
      </Box>
      <Box position="absolute" right="0" textAlign="right">
        {!!general.has_photos &&
          general.photos.map((p, i) => (
            <Box key={i} inline textAlign="center" color="label">
              <img
                src={p}
                style={{
                  width: '96px',
                  'margin-bottom': '0.5rem',
                  '-ms-interpolation-mode': 'nearest-neighbor',
                }}
              />
              <br />
              Photo #{i + 1}
            </Box>
          ))}
      </Box>
    </>
  );
};

const SecurityRecordsViewSecurity = (_properties, context) => {
  const { act, data } = useBackend(context);
  const { security } = data;
  if (!security || !security.fields) {
    return (
      <Box color="bad">
        Security records lost!
        <br />
        <Button
          icon="pen"
          content="Create New Record"
          mt="0.5rem"
          onClick={() => act('new_security')}
        />
      </Box>
    );
  }
  return (
    <Stack vertical>
      <LabeledList>
        {security.fields.map((field, i) => (
          <LabeledList.Item key={i} label={field.field} prewrap>
            {decodeHtmlEntities(field.value)}
            {!!field.edit && (
              <Button
                icon="pen"
                ml="0.5rem"
                mb={field.line_break ? '1rem' : 'initial'}
                onClick={() => doEdit(context, field)}
              />
            )}
          </LabeledList.Item>
        ))}
      </LabeledList>
      <Section
        title="Comments/Log"
        buttons={
          <Button
            icon="comment"
            content="Add Entry"
            onClick={() => modalOpen(context, 'comment_add')}
          />
        }
      >
        {security.comments.length === 0 ? (
          <Box color="label">No comments found.</Box>
        ) : (
          security.comments.map((comment, i) => (
            <Box key={i} prewrap>
              <Box color="label" inline>
                {comment.header || 'Auto-generated'}
              </Box>
              <br />
              {comment.text || comment}
              <Button
                icon="comment-slash"
                color="bad"
                ml="0.5rem"
                onClick={() => act('comment_delete', { id: i + 1 })}
              />
            </Box>
          ))
        )}
      </Section>
    </Stack>
  );
};
